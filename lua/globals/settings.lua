--[[ To use a more declarative syntax, you could do something like this:

local function set_opts(opts_table)
  for k, v in pairs(opts_table) do
    vim.opt[k] = v
  end
end

set_opts {
  mouse = 'n',
  fillchars = { eob = "~" },
}

--]]

--[[ Global option names

For those wondering how to get the values at the top level,
    you could use Lua's `setfenv` function to set the environment
    equal to the vim.opt dict

cc @mccanch

setfenv(function()
    mouse = 'n'
end, vim.opt)()

--]]

local if_nil = function(a, b)
  if a == nil then
    return b
  end
  return a
end

local singular_values = {
  ['boolean'] = true,
  ['number']  = true,
  ['nil']     = true,
}

local set_key_value = function(t, key_value_str)
  assert(string.find(key_value_str, ":"), "Must have a :" .. tostring(key_value_str))

  local key, value = unpack(vim.split(key_value_str, ":"))
  key = vim.trim(key)
  value = vim.trim(value)

  t[key] = value
end

local convert_vimoption_to_lua = function(option, val)
  -- Short circuit if we've already converted!
  if type(val) == 'table' then
    return val
  end

  if singular_values[type(val)] then
    return val
  end

  if type(val) == "string" then
    -- TODO: Bad hax I think
    if string.find(val, ":") then
      local result = {}
      local items = vim.split(val, ",")
      for _, item in ipairs(items) do
        set_key_value(result, item)
      end

      return result
    else
      return vim.split(val, ",")
    end
  end
end

-- local concat_keys = function(t, sep)
--   return table.concat(vim.tbl_keys(t), sep)
-- end

local concat_key_values = function(t, sep, divider)
  local final = {}
  for k, v in pairs(t) do
    table.insert(final, string.format('%s%s%s', k, divider, v))
  end

  table.sort(final)
  return table.concat(final, sep)
end

local remove_duplicate_values = function(t)
  local result = {}
  for _, v in ipairs(t) do
    result[v] = true
  end

  return vim.tbl_keys(result)
end

local remove_value = function(t, val)
  if vim.tbl_islist(t) then
    local remove_index = nil
    for i, v in ipairs(t) do
      if v == val then
        remove_index = i
      end
    end

    if remove_index then
      table.remove(t, remove_index)
    end
  else
    t[val] = nil
  end

  return t
end

local add_value = function(current, new)
  if singular_values[type(current)] then
    error(
      "This is not possible to do. Please do something different: "
      .. tostring(current)
      .. " // "
      .. tostring(new)
    )
  end

  if type(new) == 'string' then
    if vim.tbl_islist(current) then
      table.insert(current, new)
    else
      set_key_value(current, new)
    end

    return current
  elseif type(new) == 'table' then
    if vim.tbl_islist(current) then
      assert(vim.tbl_islist(new))
      vim.list_extend(current, new)
    else
      assert(not vim.tbl_islist(new), vim.inspect(new) .. vim.inspect(current))
      current = vim.tbl_extend("force", current, new)
    end

    return current
  else
    error("Unknown type")
  end
end

local convert_lua_to_vimoption = function(t)
  if vim.tbl_islist(t) then
    t = remove_duplicate_values(t)

    table.sort(t)
    return table.concat(t, ',')
  else
    return concat_key_values(t, ',', ':')
  end
end

local clean_value = function(v)
  if singular_values[type(v)] then
    return v
  end

  local result = v:gsub('^,', '')

  return result
end

local opt_mt

opt_mt = {
  __index = function(t, k)
    if k == '_value' then
      return rawget(t, k)
    end

    return setmetatable({ _option = k, }, opt_mt)
  end,

  __newindex = function(t, k, v)
    if k == '_value' then
      return rawset(t, k, v)
    end

    if type(v) == 'table' then
      local new_value
      if getmetatable(v) ~= opt_mt then
        new_value = v
      else
        assert(v._value, "Must have a value to set this")
        new_value = v._value
      end

      vim.o[k] = convert_lua_to_vimoption(new_value)
      return
    end

    if v == nil then
      v = ''
    end

    -- TODO: Figure out why nvim_set_option doesn't override values the same way.
    -- @bfredl said he will fix this for me, so I can just use nvim_set_option
    if type(v) == 'boolean' then
      vim.o[k] = clean_value(v)
      if v then
        vim.cmd(string.format("set %s", k))
      else
        vim.cmd(string.format("set no%s", k))
      end
    else
      vim.cmd(string.format("set %s=%s", k, clean_value(v)))
    end
  end,

  __add = function(left, right)
    --[[
    set.wildignore = set.wildignore + 'hello'
    set.wildignore = set.wildignore + { '*.o', '*~', }
    --]]

    assert(left._option, "must have an option key")
    if left._option == 'foldcolumn' then
      error("not implemented for foldcolumn.. use a string")
    end

    local existing = if_nil(left._value, vim.o[left._option])
    local current = convert_vimoption_to_lua(left._option, existing)
    if not current then
      left._value = convert_vimoption_to_lua(right)
    end

    left._value = add_value(current, right)
    return left
  end,

  __sub = function(left, right)
    assert(left._option, "must have an option key")

    local existing = if_nil(left._value, vim.o[left._option])
    local current = convert_vimoption_to_lua(left._option, existing)
    if not current then
      return left
    end

    left._value = remove_value(current, right)
    return left
  end
}

vim.opt = setmetatable({}, opt_mt)

return {
  convert_vimoption_to_lua = convert_vimoption_to_lua,
  opt = vim.opt,
  opt_mt = opt_mt
}

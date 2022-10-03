local M = {}

-- revisit this
-- function prequire(package)
--   local status, lib = pcall(require, package)
--   if status then
--     return lib
--   else
--     vim.notify("Failed to require '" .. package .. "' from " .. debug.getinfo(2).source)
--     return nil
--   end
-- end

local function _assign(old, new, k)
  local otype = type(old[k])
  local ntype = type(new[k])
  -- print("hi")
  if (otype == "thread" or otype == "userdata") or (ntype == "thread" or ntype == "userdata") then
    vim.notify(string.format("warning: old or new attr %s type be thread or userdata", k))
  end
  old[k] = new[k]
end

local function _replace(old, new, repeat_tbl)
  if repeat_tbl[old] then
    return
  end
  repeat_tbl[old] = true

  local dellist = {}
  for k, v in pairs(old) do
    if not new[k] then
      table.insert(dellist, k)
    end
  end
  for _, v in ipairs(dellist) do
    old[v] = nil
  end

  for k, v in pairs(new) do
    if not old[k] then
      old[k] = new[k]
    else
      if type(old[k]) ~= type(new[k]) then
        vim.notify(string.format("warning: attr %s old type no equal new type!!!", k))
        _assign(old, new, k)
      else
        if type(old[k]) == "table" then
          _replace(old[k], new[k], repeat_tbl)
        else
          _assign(old, new, k)
        end
      end
    end
  end
end

function reload(mod)
  if not package.loaded[mod] then
    local m = require(mod)
    return m
  end
  -- vim.notify "begin reload!!!"

  local old = package.loaded[mod]
  package.loaded[mod] = nil
  local new = require(mod)

  if type(old) == "table" and type(new) == "table" then
    -- vim.notify "pick object in new module to old module!!!"
    local repeat_tbl = {}
    _replace(old, new, repeat_tbl)
  end

  package.loaded[mod] = old
  -- vim.notify "finish reload!!!"
  return old
end

return M

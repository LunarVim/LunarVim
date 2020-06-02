--- Keybind management
-- @module c.keybind

local plug = require("c.plug")
local edit_mode = require("c.edit_mode")

local keybind = {}

keybind._leader_info = {}

--- Split a key sequence string like "fed" into { "f", "e", "d" }
local function split_keys(keys)
  local keys_split = {}

  -- TODO: Support <C-f> and <tab> and etc. style syntax
  for c in string.gmatch(keys, ".") do
    table.insert(keys_split, c)
  end

  return keys_split
end

--- Add which-key info for a keybind
local function add_info(keys, name)
  -- Find our info table and strip the prefix
  local t
  if vim.startswith(keys, "<leader>") then
    keys = keys:sub(9)
    t = keybind._leader_info
  else
    return
  end

  -- Find/create tables along the path
  local keys_split = split_keys(keys)
  local final_key = keys_split[#keys_split]
  keys_split[#keys_split] = nil
  for _, key in ipairs(keys_split) do
    local new_t = t[key]
    if new_t == nil then
      new_t = {}
      t[key] = new_t
    end
    t = new_t
  end

  t[final_key] = name

  --[[
    Go ahead and update the global whichkey map with each binding
    so we don't have to "initialize" this property after all
    layers have finished `init_config()` 
  --]]
  vim.g.which_key_map = keybind._leader_info
end

--- Map a key sequence to a Vim command
--
-- @param mode An edit mode from `c.edit_mode`
-- @tparam string keys The keys to press (eg: `<leader>feR`)
-- @tparam string command The Vim command to bind to the key sequence (eg: `:source $MYVIMRC<CR>`)
-- @tparam table options See `https://neovim.io/doc/user/api.html#nvim_set_keymap()` (eg: `{ noremap = true }`)
-- @tparam[opt] string name A helpful display name
function keybind.bind_command(mode, keys, command, options, name)
  options = options or {}

  vim.api.nvim_set_keymap(mode.map_prefix, keys, command, options)

  if name ~= nil then
    add_info(keys, name)
  end
end

--- Map a key sequence to a Vim command
--
-- @param mode An edit mode from `c.edit_mode`
-- @tparam string keys The keys to press (eg: `<leader>feR`)
-- @tparam string command The Vim command to bind to the key sequence (eg: `:source $MYVIMRC<CR>`)
-- @tparam table options See `https://neovim.io/doc/user/api.html#nvim_set_keymap()` (eg: `{ noremap = true }`)
-- @tparam[opt] string name A helpful display name
function keybind.buf_bind_command(mode, keys, command, options, name)
  options = options or {}

  vim.api.nvim_buf_set_keymap(0, mode.map_prefix, keys, command, options)

  if name ~= nil then
    add_info(keys, name)
  end
end

keybind._bound_funcs = {}

--- Map a key sequence to a Lua function
--
-- @param mode An edit mode from `c.edit_mode`
-- @tparam string keys The keys to press (eg: `<leader>feR`)
-- @tparam function func The Lua function to bind to the key sequence
-- @tparam table options See `https://neovim.io/doc/user/api.html#nvim_set_keymap()` (eg: `{ noremap = true }`)
-- @tparam[opt] string name A helpful display name
function keybind.bind_function(mode, keys, func, options, name)
  options = options or {}
  options.noremap = true

  local func_name = "bind_" .. mode.map_prefix .. "_" .. keys

  local func_name_escaped = func_name
  -- Escape Lua things
  func_name_escaped = func_name_escaped:gsub("'", "\\'")
  func_name_escaped = func_name_escaped:gsub('"', '\\"')
  func_name_escaped = func_name_escaped:gsub("\\[", "\\[")
  func_name_escaped = func_name_escaped:gsub("\\]", "\\]")

  -- Escape VimScript things
  -- We only escape `<` - I couldn't be bothered to deal with how <lt>/<gt> have angle brackets in themselves
  -- And this works well-enough anyways
  func_name_escaped = func_name_escaped:gsub("<", "<lt>")

  keybind._bound_funcs[func_name] = func

  local lua_command = ":lua require('c.keybind')._bound_funcs['" .. func_name_escaped .. "']()<CR>"
  -- Prefix with <C-o> if this is an insert-mode mapping
  if mode.map_prefix == "i" then
    lua_command = "<C-o>" .. lua_command
  end

  vim.api.nvim_set_keymap(mode.map_prefix, keys, lua_command, options)

  if name ~= nil then
    add_info(keys, name)
  end
end

--- Set a key group name
--
-- @tparam string keys The keys sequence (eg: `<leader>fe`)
-- @tparam string name The group name (eg: `Editor`)
function keybind.set_group_name(keys, name)
  local t
  if vim.startswith(keys, "<leader>") then
    keys = keys:sub(9)
    t = keybind._leader_info
  else
    return
  end

  local keys_split = split_keys(keys)
  for _, key in ipairs(keys_split) do
    local new_t = t[key]
    if new_t == nil then
      new_t = {}
      t[key] = new_t
    end
    t = new_t
  end

  t.name = "+" .. name
end

return keybind

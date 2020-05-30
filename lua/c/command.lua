--- Command management
-- @module c.command

local edit_mode = require("c.edit_mode")

local command = {}

command._bound_funcs = {}

--- Makes a new command to call a Lua function
--
-- @tparam string cmd The command name
-- @tparam function func The function to call with args as func(arg_string)
-- @tparam[opt] int|string num_args see `:help :command-nargs`
function command.make_command(cmd, func, num_args)
  num_args = num_args or 0

  local func_name = "cmd_" .. cmd

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

  command._bound_funcs[func_name] = func

  local lua_command = "lua require('c.command')._bound_funcs['" .. func_name_escaped .. "']('<args>')"
  vim.cmd("command! -nargs=" .. num_args .. " " .. cmd .. " " .. lua_command)
end

return command

local M = {
  USER_CONF_PATH = "~/.config/lvim/config.lua",
}

-- Load LVIM default config and applies the user's one on top of it
-- @param keymap The key mapping service for loading key mappings
-- @param user_conf_path The path to the user's configuration file
function M:load(keymap, user_conf_path)
  -- Define the lvim global variable
  require "config.default-config"

  -- Load default vim settings
  local settings = require "config.settings"
  settings.load_options()

  -- Load the user configuration
  local ok, err = pcall(vim.cmd, "luafile " .. user_conf_path)
  if not ok then
    print("Invalid user configuration " .. user_conf_path)
    print(err)
  end

  settings.load_commands()

  -- Load auto commands
  local autocmds = require "core.autocmds"
  autocmds.define_augroups(lvim.autocommands)

  -- Load default keymaps and override them with user ones
  local default_keymaps = require "config.keymappings"
  keymap.load(default_keymaps.keymaps, default_keymaps.opts)
  keymap.load(lvim.keys, default_keymaps.opts)
end

return M

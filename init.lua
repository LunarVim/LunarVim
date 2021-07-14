require "default-config"
require "keymappings"

local plugin_loader = require("plugin-loader").init()

local function load_config()
  require "default-config"
  local status_ok, error = pcall(vim.cmd, "luafile " .. CONFIG_PATH .. "/lv-config.lua")
  if not status_ok then
    print "something is wrong with your lv-config"
    print(error)
  end
end

local function load_plugins()
  local plugins = require "plugins"
  plugin_loader:load { plugins, O.user_plugins }
  vim.g.colors_name = O.colorscheme -- Colorscheme must get called after plugins are loaded or it will break new installs.
end

load_config()
load_plugins()

require "settings"
require "lv-utils"

local watcher = require "file-watcher"
watcher:watch("lv-config.lua", function()
  require("lv-utils").uncache_modules { "lv-config", "default-config", "lua/core/" }
  load_config()
  load_plugins()
  vim.cmd ":PackerClean"
  vim.cmd ":PackerInstall"
  vim.cmd ":PackerCompile"
end)

-- TODO: these guys need to be in language files
-- require "lsp"
-- if O.lang.emmet.active then
--   require "lsp.emmet-ls"
-- end
-- if O.lang.tailwindcss.active then
--   require "lsp.tailwind

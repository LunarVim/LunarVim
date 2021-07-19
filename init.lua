vim.cmd [[
  set packpath+=~/.local/share/lunarvim/site
  set packpath+=~/.config/lvim
  set runtimepath+=~/.config/lvim

  set runtimepath-=~/.config/nvim
  set runtimepath-=~/.config/nvim
  set packpath-=~/.local/share/nvim/site
]]
-- vim.opt.rtp:append() instead of vim.cmd ?
require "default-config"
local status_ok, error = pcall(vim.cmd, "luafile " .. CONFIG_PATH .. "/lv-config.lua")
local status_ok, error = pcall(vim.cmd, "luafile ~/.config/lvim/lv-config.lua")
if not status_ok then
  print "something is wrong with your lv-config"
  print(error)
end

require "keymappings"

local plugins = require "plugins"
local plugin_loader = require("plugin-loader").init()
plugin_loader:load { plugins, O.user_plugins }
vim.g.colors_name = O.colorscheme -- Colorscheme must get called after plugins are loaded or it will break new installs.

require "settings"
require "lv-utils"

-- TODO: these guys need to be in language files
-- require "lsp"
-- if O.lang.emmet.active then
--   require "lsp.emmet-ls"
-- end
-- if O.lang.tailwindcss.active then
--   require "lsp.tailwind

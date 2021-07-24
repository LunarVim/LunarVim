vim.cmd [[
  set packpath-=~/.config/nvim
  set packpath-=~/.config/nvim/after
  set packpath-=~/.local/share/nvim/site
  set packpath^=~/.local/share/lunarvim/site
  set packpath^=~/.config/lvim

  set runtimepath-=~/.config/nvim
  set runtimepath-=~/.config/nvim/after
  set runtimepath+=~/.config/lvim
  set runtimepath^=~/.local/share/lunarvim/lvim/after
]]
-- vim.opt.rtp:append() instead of vim.cmd ?
require "default-config"
require "settings"
local status_ok, error = pcall(vim.cmd, "luafile ~/.config/lvim/lv-config.lua")
if not status_ok then
  print "something is wrong with your lv-config"
  print(error)
end

require "keymappings"

local plugins = require "plugins"
local plugin_loader = require("plugin-loader").init()
plugin_loader:load { plugins, O.plugins }
vim.g.colors_name = O.colorscheme -- Colorscheme must get called after plugins are loaded or it will break new installs.
vim.cmd("colorscheme " .. O.colorscheme)

local utils = require "lv-utils"
utils.toggle_autoformat()
require("lsp").setup_handlers()

require("nlspsettings").setup {
  config_home = os.getenv "HOME" .. "/.config/lvim/lsp-settings",
}
local null_ls = require "null-ls"

null_ls.config {}
require("lspconfig")["null-ls"].setup {}

-- TODO: these guys need to be in language files
-- if O.lang.emmet.active then
--   require "lsp.emmet-ls"
-- end
-- if O.lang.tailwindcss.active then
--   require "lsp.tailwind

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

local function file_exists(name)
  local f = io.open(name, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

local lvim_path = os.getenv "HOME" .. "/.config/lvim/"
USER_CONFIG_PATH = lvim_path .. "config.lua"
local config_exist = file_exists(USER_CONFIG_PATH)
if not config_exist then
  USER_CONFIG_PATH = lvim_path .. "lv-config.lua"
  print "Rename ~/.config/lvim/lv-config.lua to config.lua"
end

require "default-config"
local autocmds = require "core.autocmds"
require("settings").load_options()

local status_ok, error = pcall(vim.cmd, "luafile " .. USER_CONFIG_PATH)
if not status_ok then
  print("something is wrong with your " .. USER_CONFIG_PATH)
  print(error)
end
require("settings").load_commands()
autocmds.define_augroups(lvim.autocommands)

local keymap = require "utils.keymap"
local default_keymaps = require "keymappings"
keymap.load(default_keymaps.keymaps, default_keymaps.opts)
keymap.load(lvim.keys, default_keymaps.opts)

local plugins = require "plugins"
local plugin_loader = require("plugin-loader").init()
plugin_loader:load { plugins, lvim.plugins }
vim.g.colors_name = lvim.colorscheme -- Colorscheme must get called after plugins are loaded or it will break new installs.
vim.cmd("colorscheme " .. lvim.colorscheme)

local utils = require "utils"
utils.toggle_autoformat()
local commands = require "core.commands"
commands.load(commands.defaults)

require("lsp").config()

local null_status_ok, null_ls = pcall(require, "null-ls")
if null_status_ok then
  null_ls.config {}
  require("lspconfig")["null-ls"].setup {}
end

local lsp_settings_status_ok, lsp_settings = pcall(require, "nlspsettings")
if lsp_settings_status_ok then
  lsp_settings.setup {
    config_home = os.getenv "HOME" .. "/.config/lvim/lsp-settings",
  }
end

-- TODO: these guys need to be in language files
-- if lvim.lang.emmet.active then
--   require "lsp.emmet-ls"
-- end
-- if lvim.lang.tailwindcss.active then
--   require "lsp.tailwind

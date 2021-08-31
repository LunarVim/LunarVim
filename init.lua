-- {{{ Bootstrap
local home_dir = vim.loop.os_homedir()

vim.opt.rtp:append(home_dir .. "/.local/share/lunarvim/lvim")

vim.opt.rtp:remove(home_dir .. "/.local/share/nvim/site")
vim.opt.rtp:remove(home_dir .. "/.local/share/nvim/site/after")
vim.opt.rtp:prepend(home_dir .. "/.local/share/lunarvim/site")
vim.opt.rtp:append(home_dir .. "/.local/share/lunarvim/site/after")

vim.opt.rtp:remove(home_dir .. "/.config/nvim")
vim.opt.rtp:remove(home_dir .. "/.config/nvim/after")
vim.opt.rtp:prepend(home_dir .. "/.config/lvim")
vim.opt.rtp:append(home_dir .. "/.config/lvim/after")

-- TODO: we need something like this: vim.opt.packpath = vim.opt.rtp
vim.cmd [[let &packpath = &runtimepath]]
-- }}}


local function load_config()
  local defaults = require "config.defaults"
  local Config = require "config"
  local config = Config(defaults)

  local settings = require "config.settings"
  settings.load_options()

  local keymappings = require "config.keymappings"
  keymappings.setup(config:sub "keys")

  local autocommands = require "config.autocmds"
  autocommands.setup(config:sub "autocommands")

  local builtins = require "core.builtins"
  builtins.setup(config:sub "builtins")

  -- Fallback config.lua to lv-config.lua
  local utils = require "utils"
  local path = string.format("%s/.config/lvim/config.lua", home_dir)
  if not utils.is_file(path) then
    local lv_config = path:gsub("config.lua$", "lv-config.lua")
    print(path, "not found, falling back to", lv_config)

    path = lv_config
  end
  config.path = path
  config:load()

  local autocmds = require "core.autocmds"
  autocmds.define_augroups(config:get "autocommands")
  settings.load_commands(config)

  return config
end

_G.PLENARY_DEBUG = false -- Plenary destroys cache with this undocumented flag set to true by default
require("impatient").enable_profile()

local config = load_config()
-- GLOBAL configuration
-- This varibale is required as packer cannot capture variables because it uses string.dump
lvim = config.entries

local plugins = require "plugins"
local plugin_loader = require("plugin-loader").init()
plugin_loader:load { plugins, config:get "plugins" }

local Log = require "core.log"
Log:info "Starting LunarVim"

vim.g.colors_name = config:get "colorscheme"
vim.cmd("colorscheme " .. config:get "colorscheme")

local utils = require "utils"
utils.toggle_autoformat()
local commands = require "core.commands"
commands.load(commands.defaults)

require("lsp").config()

local null_status_ok, null_ls = pcall(require, "null-ls")
if null_status_ok then
  null_ls.config {}
  require("lspconfig")["null-ls"].setup(config:get "lsp.null_ls.setup")
end

local lsp_settings_status_ok, lsp_settings = pcall(require, "nlspsettings")
if lsp_settings_status_ok then
  lsp_settings.setup {
    config_home = home_dir .. "/.config/lvim/lsp-settings",
  }
end

local keymap = require "keymappings"
keymap.setup(config:get "leader", config:get "keys")


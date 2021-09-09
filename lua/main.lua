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

  -- Fallback config.lua to lv-config.lua
  local home_dir = vim.loop.os_homedir()
  local config_path = string.format("%s/.config/lvim/config.lua", home_dir)
  local utils = require "utils"
  if not utils.is_file(config_path) then
    local lv_config = config_path:gsub("config.lua$", "lv-config.lua")
    print(config_path, "not found, falling back to", lv_config)

    config_path = lv_config
  end
  local user_config, err = loadfile(config_path)
  if err then
    print("Invalid configuration", config_path)
    print(err)
    return nil
  end
  config:merge(user_config())
  lvim = config.entries
  config.path = config_path

  local Log = require "core.log"
  Log:config(config:sub "log")

  local autocmds = require "core.autocmds"
  autocmds.define_augroups(config:get "autocommands")
  settings.load_commands(config)

  return config
end

local function main()
  local config = load_config()
  if not config then
    return
  end

  local builtins = require "core.builtins"
  local plugin_loader = require("core.plugin-loader").init()
  builtins:setup(config:sub "builtins", plugin_loader)
  builtins:load(config:get "plugins")

  local Log = require "core.log"
  Log:info "Starting LunarVim"

  vim.g.colors_name = config:get "colorscheme"
  vim.cmd("colorscheme " .. config:get "colorscheme")

  local utils = require "utils"
  utils.toggle_autoformat()
  local commands = require "core.commands"
  commands.load(commands.defaults)

  local lsp = require "lsp"
  lsp:setup(config:get "lsp")

  local null_status_ok, null_ls = pcall(require, "null-ls")
  if null_status_ok then
    null_ls.config {}
    require("lspconfig")["null-ls"].setup(lsp.config.null_ls.setup)
  end
  local lsp_settings_status_ok, lsp_settings = pcall(require, "nlspsettings")
  if lsp_settings_status_ok then
    local home_dir = vim.loop.os_homedir()
    lsp_settings.setup {
      config_home = home_dir .. "/.config/lvim/lsp-settings",
    }
  end

  local keymap = require "core.service.keymap"
  keymap.setup(config:get "leader", config:get "keys")
end

return main

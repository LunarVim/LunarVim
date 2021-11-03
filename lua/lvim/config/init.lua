local utils = require "lvim.utils"
local Log = require "lvim.core.log"

local M = {}
local user_config_dir = get_config_dir()
local user_config_file = utils.join_paths(user_config_dir, "config.lua")

local function apply_defaults(configs, defaults)
  configs = configs or {}
  return vim.tbl_deep_extend("keep", configs, defaults)
end

---Get the full path to the user configuration file
---@return string
function M:get_user_config_path()
  return user_config_file
end

--- Initialize lvim default configuration
-- Define lvim global variable
function M:init()
  if vim.tbl_isempty(lvim or {}) then
    lvim = require "lvim.config.defaults"
    local home_dir = vim.loop.os_homedir()
    lvim.vsnip_dir = utils.join_paths(home_dir, ".config", "snippets")
    lvim.database = { save_location = utils.join_paths(home_dir, ".config", "lunarvim_db"), auto_execute = 1 }
  end

  local builtins = require "lvim.core.builtins"
  builtins.config { user_config_file = user_config_file }

  local settings = require "lvim.config.settings"
  settings.load_options()

  local default_keymaps = require("lvim.keymappings").get_defaults()
  lvim.keys = apply_defaults(lvim.keys, default_keymaps)

  local autocmds = require "lvim.core.autocmds"
  lvim.autocommands = apply_defaults(lvim.autocommands, autocmds.load_augroups())

  local lvim_lsp_config = require "lvim.lsp.config"
  lvim.lsp = apply_defaults(lvim.lsp, vim.deepcopy(lvim_lsp_config))

  local supported_languages = require "lvim.config.supported_languages"
  require("lvim.lsp.manager").init_defaults(supported_languages)
end

local function handle_deprecated_settings()
  local function deprecation_notice(setting)
    local in_headless = #vim.api.nvim_list_uis() == 0
    if in_headless then
      return
    end

    local msg = string.format(
      "Deprecation notice: [%s] setting is no longer supported. See https://github.com/LunarVim/LunarVim#breaking-changes",
      setting
    )
    vim.schedule(function()
      vim.notify(msg, vim.log.levels.WARN)
    end)
  end

  ---lvim.lang.FOO.lsp
  for lang, entry in pairs(lvim.lang) do
    local deprecated_config = entry["lsp"] or {}
    if not vim.tbl_isempty(deprecated_config) then
      deprecation_notice(string.format("lvim.lang.%s.lsp", lang))
    end
  end
end

--- Override the configuration with a user provided one
-- @param config_path The path to the configuration overrides
function M:load(config_path)
  local autocmds = require "lvim.core.autocmds"
  config_path = config_path or self.get_user_config_path()
  local ok, err = pcall(dofile, config_path)
  if not ok then
    if utils.is_file(user_config_file) then
      Log:warn("Invalid configuration: " .. err)
    else
      Log:warn(string.format("Unable to find configuration file [%s]", config_path))
    end
  end

  handle_deprecated_settings()

  autocmds.define_augroups(lvim.autocommands)

  vim.g.mapleader = (lvim.leader == "space" and " ") or lvim.leader
  require("lvim.keymappings").load(lvim.keys)

  local settings = require "lvim.config.settings"
  settings.load_commands()
end

--- Override the configuration with a user provided one
-- @param config_path The path to the configuration overrides
function M:reload()
  local lvim_modules = {}
  for module, _ in pairs(package.loaded) do
    if module:match "lvim.core" then
      package.loaded[module] = nil
      table.insert(lvim_modules, module)
    end
  end

  M:init()
  M:load()

  local plugins = require "lvim.plugins"
  utils.toggle_autoformat()
  local plugin_loader = require "lvim.plugin-loader"
  plugin_loader.cache_clear()
  plugin_loader.load { plugins, lvim.plugins }
  vim.cmd ":PackerInstall"
  vim.cmd ":PackerCompile"
  -- vim.cmd ":PackerClean"
  require("lvim.lsp").setup()
  Log:info "Reloaded configuration"
end

return M

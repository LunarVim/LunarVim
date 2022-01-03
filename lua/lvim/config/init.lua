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
    lvim = vim.deepcopy(require "lvim.config.defaults")
    local home_dir = vim.loop.os_homedir()
    lvim.vsnip_dir = utils.join_paths(home_dir, ".config", "snippets")
    lvim.database = { save_location = utils.join_paths(home_dir, ".config", "lunarvim_db"), auto_execute = 1 }
  end

  require("lvim.keymappings").load_defaults()

  local builtins = require "lvim.core.builtins"
  builtins.config { user_config_file = user_config_file }

  local settings = require "lvim.config.settings"
  settings.load_options()

  local autocmds = require "lvim.core.autocmds"
  lvim.autocommands = apply_defaults(lvim.autocommands, autocmds.load_augroups())

  local lvim_lsp_config = require "lvim.lsp.config"
  lvim.lsp = apply_defaults(lvim.lsp, vim.deepcopy(lvim_lsp_config))

  require("lvim.lsp.manager").init_defaults()
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
      Log:warn(msg)
    end)
  end

  ---lvim.lang.FOO.lsp
  for lang, entry in pairs(lvim.lang) do
    local deprecated_config = entry.formatters or entry.linters or {}
    if not vim.tbl_isempty(deprecated_config) then
      deprecation_notice(string.format("lvim.lang.%s", lang))
    end
  end

  -- lvim.lsp.popup_border
  if vim.tbl_contains(vim.tbl_keys(lvim.lsp), "popup_border") then
    deprecation_notice "lvim.lsp.popup_border"
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

  if lvim.transparent_window then
    autocmds.enable_transparent_mode()
  end
end

--- Override the configuration with a user provided one
-- @param config_path The path to the configuration overrides
function M:reload()
  require_clean("lvim.utils.hooks").run_pre_reload()

  M:init()
  M:load()

  require("lvim.core.autocmds").configure_format_on_save()

  local plugins = require "lvim.plugins"
  local plugin_loader = require "lvim.plugin-loader"

  plugin_loader.load { plugins, lvim.plugins }
  require_clean("lvim.utils.hooks").run_post_reload()
end

return M

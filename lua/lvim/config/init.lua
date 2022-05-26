local utils = require "lvim.utils"
local Log = require "lvim.core.log"

local M = {}
local user_config_dir = get_config_dir()
local user_config_file = utils.join_paths(user_config_dir, "config.lua")

---Get the full path to the user configuration file
---@return string
function M:get_user_config_path()
  return user_config_file
end

--- Initialize lvim default configuration and variables
function M:init()
  lvim = vim.deepcopy(require "lvim.config.defaults")

  require("lvim.keymappings").load_defaults()

  local builtins = require "lvim.core.builtins"
  builtins.config { user_config_file = user_config_file }

  local settings = require "lvim.config.settings"
  settings.load_defaults()

  local autocmds = require "lvim.core.autocmds"
  autocmds.load_defaults()

  local lvim_lsp_config = require "lvim.lsp.config"
  lvim.lsp = vim.deepcopy(lvim_lsp_config)

  ---@deprecated replaced with lvim.builtin.alpha
  lvim.builtin.dashboard = {
    active = false,
    on_config_done = nil,
    search_handler = "",
    disable_at_vim_enter = 0,
    session_directory = "",
    custom_header = {},
    custom_section = {},
    footer = {},
  }

  lvim.builtin.luasnip = {
    sources = {
      friendly_snippets = true,
    },
  }
end

local function handle_deprecated_settings()
  local function deprecation_notice(setting, new_setting)
    local in_headless = #vim.api.nvim_list_uis() == 0
    if in_headless then
      return
    end

    local msg = string.format(
      "Deprecation notice: [%s] setting is no longer supported. %s",
      setting,
      new_setting or "See https://github.com/LunarVim/LunarVim#breaking-changes"
    )
    vim.schedule(function()
      vim.notify_once(msg, vim.log.levels.WARN)
    end)
  end

  ---lvim.lang.FOO.lsp
  for lang, entry in pairs(lvim.lang) do
    local deprecated_config = entry.formatters or entry.linters or {}
    if not vim.tbl_isempty(deprecated_config) then
      deprecation_notice(string.format("lvim.lang.%s", lang))
    end
  end

  -- lvim.lsp.override
  if lvim.lsp.override and not vim.tbl_isempty(lvim.lsp.override) then
    deprecation_notice("lvim.lsp.override", "Use `lvim.lsp.automatic_configuration.skipped_servers` instead")
    vim.tbl_map(function(c)
      if not vim.tbl_contains(lvim.lsp.automatic_configuration.skipped_servers, c) then
        table.insert(lvim.lsp.automatic_configuration.skipped_servers, c)
      end
    end, lvim.lsp.override)
  end

  -- lvim.lsp.popup_border
  if vim.tbl_contains(vim.tbl_keys(lvim.lsp), "popup_border") then
    deprecation_notice "lvim.lsp.popup_border"
  end

  -- dashboard.nvim
  if lvim.builtin.dashboard.active then
    deprecation_notice("lvim.builtin.dashboard", "Use `lvim.builtin.alpha` instead. See LunarVim#1906")
  end

  if lvim.autocommands.custom_groups then
    deprecation_notice(
      "lvim.autocommands.custom_groups",
      "Use vim.api.nvim_create_autocmd instead or check LunarVim#2592 to learn about the new syntax"
    )
  end
end

--- Override the configuration with a user provided one
-- @param config_path The path to the configuration overrides
function M:load(config_path)
  local autocmds = require "lvim.core.autocmds"
  config_path = config_path or self:get_user_config_path()
  local ok, err = pcall(dofile, config_path)
  if not ok then
    if utils.is_file(user_config_file) then
      Log:warn("Invalid configuration: " .. err)
    else
      vim.notify_once(string.format("Unable to find configuration file [%s]", config_path), vim.log.levels.WARN)
    end
  end

  handle_deprecated_settings()

  autocmds.define_autocmds(lvim.autocommands)

  vim.g.mapleader = (lvim.leader == "space" and " ") or lvim.leader

  require("lvim.keymappings").load(lvim.keys)

  if lvim.transparent_window then
    autocmds.enable_transparent_mode()
  end
end

--- Override the configuration with a user provided one
-- @param config_path The path to the configuration overrides
function M:reload()
  vim.schedule(function()
    require_clean("lvim.utils.hooks").run_pre_reload()

    M:load()

    require("lvim.core.autocmds").configure_format_on_save()

    local plugins = require "lvim.plugins"
    local plugin_loader = require "lvim.plugin-loader"

    plugin_loader.reload { plugins, lvim.plugins }
    require_clean("lvim.utils.hooks").run_post_reload()
  end)
end

return M

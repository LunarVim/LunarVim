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

  lvim.builtin.luasnip = {
    sources = {
      friendly_snippets = true,
    },
  }

  require("lvim.config._deprecated").handle()
end

--- Override the configuration with a user provided one
-- @param config_path The path to the configuration overrides
function M:load(config_path)
  local autocmds = reload "lvim.core.autocmds"
  config_path = config_path or self:get_user_config_path()
  local ok, err = pcall(dofile, config_path)
  if not ok then
    if utils.is_file(user_config_file) then
      Log:warn("Invalid configuration: " .. err)
    else
      vim.notify_once(
        string.format("User-configuration not found. Creating an example configuration in %s", config_path)
      )
      local example_config = join_paths(get_lvim_base_dir(), "utils", "installer", "config.example.lua")
      vim.loop.fs_copyfile(example_config, config_path)
    end
  end

  Log:set_level(lvim.log.level)

  autocmds.define_autocmds(lvim.autocommands)

  vim.g.mapleader = (lvim.leader == "space" and " ") or lvim.leader

  reload("lvim.keymappings").load(lvim.keys)

  if lvim.transparent_window then
    autocmds.enable_transparent_mode()
  end

  if lvim.reload_config_on_save then
    autocmds.enable_reload_config_on_save()
  end
end

--- Override the configuration with a user provided one
-- @param config_path The path to the configuration overrides
function M:reload()
  vim.schedule(function()
    reload("lvim.utils.hooks").run_pre_reload()

    M:load()

    reload("lvim.core.autocmds").configure_format_on_save()

    local plugins = reload "lvim.plugins"
    local plugin_loader = reload "lvim.plugin-loader"

    plugin_loader.reload { plugins, lvim.plugins }
    reload("lvim.core.theme").setup()
    reload("lvim.utils.hooks").run_post_reload()
  end)
end

return M

local M = {}

local defaults = {
  active = true,
  on_config_done = nil,
  config = {
    highlight = {
      enable = true, -- false will disable the whole extension
      additional_vim_regex_highlighting = true,
    },
    indent = {
      enable = true,
      disable = { "yaml" },
    },
  },
}
local Log = require "core.log"

function M:setup(overrides)
  local Config = require "config"
  self.config = Config(defaults):merge(overrides).entries
end

function M:configure()
  local status_ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
  if not status_ok then
    Log:get_default().error "Failed to load nvim-treesitter.configs"
    return
  end

  treesitter_configs.setup(self.config.config)

  if self.config.on_config_done then
    self.config.on_config_done(treesitter_configs)
  end
end

return M

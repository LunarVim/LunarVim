local M = {
  defaults = {
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
  },
}

local Log = require "core.log"

function M:setup(config)
  config:merge(self.defaults)
end

function M:configure()
  local status_ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
  if not status_ok then
    Log:get_default().error "Failed to load nvim-treesitter.configs"
    return
  end

  treesitter_configs.setup(lvim.builtins.treesitter.config)

  if lvim.builtins.treesitter.on_config_done then
    lvim.builtins.treesitter.on_config_done(treesitter_configs)
  end
end

return M

local M = {}
local Log = require "core.log"

M.config = function()
  lvim.builtin.treesitter = {
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
end

M.setup = function()
  local status_ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
  if not status_ok then
    Log:get_default().error "Failed to load nvim-treesitter.configs"
    return
  end

  treesitter_configs.setup(lvim.builtin.treesitter.config)

  if lvim.builtin.treesitter.on_config_done then
    lvim.builtin.treesitter.on_config_done(treesitter_configs)
  end
end

return M

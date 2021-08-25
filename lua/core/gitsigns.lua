local M = {}

M.config = function()
  lvim.builtin.gitsigns = {
    active = true,
    on_config_done = nil,
    config = {},
  }
end

M.setup = function()
  local gitsigns = require "gitsigns"

  gitsigns.setup(lvim.builtin.gitsigns.config)
  if lvim.builtin.gitsigns.on_config_done then
    lvim.builtin.gitsigns.on_config_done(gitsigns)
  end
end

return M

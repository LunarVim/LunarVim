local M = {
  defaults = {
    active = true,
    on_config_done = nil,
    config = {},
  },
}

function M:setup(config)
  config:extend(self.defaults)
end

function M:config()
  local gitsigns = require "gitsigns"

  gitsigns.setup(lvim.builtins.gitsigns.config)
  if lvim.builtins.gitsigns.on_config_done then
    lvim.builtins.gitsigns.on_config_done(gitsigns)
  end
end

return M

local M = {
  defaults = {
    active = true,
    on_config_done = nil,
    config = {},
  },
}

function M:setup(config)
  config:merge(self.defaults)
end

function M:configure()
  local gitsigns = require "gitsigns"

  gitsigns.setup(lvim.builtins.gitsigns.config)
  if lvim.builtins.gitsigns.on_config_done then
    lvim.builtins.gitsigns.on_config_done(gitsigns)
  end
end

return M

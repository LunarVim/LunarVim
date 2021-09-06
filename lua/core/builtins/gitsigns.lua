local M = {}

local defaults = {
  active = true,
  on_config_done = nil,
  config = {
    -- Disable default keymaps
    keymaps = {},
  },
}

function M:setup(overrides)
  local Config = require "config"
  self.config = Config(defaults):merge(overrides).entries
end

function M:configure()
  local gitsigns = require "gitsigns"

  gitsigns.setup(self.config.config)
  if self.config.on_config_done then
    self.config.on_config_done(gitsigns)
  end
end

return M

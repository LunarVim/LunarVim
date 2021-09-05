local M = {}

local defaults = {
  active = true,
  on_config_done = nil,
  config = {},
}

function M:setup(overrides)
  local Config = require "config"
  self.config = Config(defaults):merge(overrides).entries
end

function M:configure()
  local nvim_comment = require "nvim_comment"

  nvim_comment.setup(self.config.config)
  if self.config.on_config_done then
    self.config.on_config_done(nvim_comment)
  end
end

return M

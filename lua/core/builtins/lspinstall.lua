local M = {}

local defaults = {
  active = true,
  on_config_done = nil,
}

function M:setup(overrides)
  local Config = require "config"
  self.config = Config(defaults)
  self.config:merge(overrides)
end

function M:configure()
  local lspinstall = require "lspinstall"

  lspinstall.setup()
  if self.config:get "on_config_done" then
    self.config:get "on_config_done"(lspinstall)
  end
end

return M

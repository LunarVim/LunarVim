local M = {}

local defaults = {
  ---@usage set to false to disable project.nvim.
  --- This is on by default since it's currently the expected behavior.
  active = true,

  on_config_done = nil,

  config = {
    ---@type string
    ---@usage path to store the project history for use in telescope
    datapath = CACHE_PATH,
  },
}

function M:setup(overrides)
  local Config = require "config"
  self.config = Config(defaults):merge(overrides).entries
end

function M:configure()
  local project = require "project_nvim"

  project.setup(self.config.config)
  if self.config.on_config_done then
    self.config.on_config_done(project)
  end
end

return M

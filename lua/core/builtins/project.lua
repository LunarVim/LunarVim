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
  self.config = Config(defaults)
  self.config:merge(overrides)
end

function M:configure()
  local project = require "project_nvim"

  project.setup(self.config:get "config")
  if self.config:get "on_config_done" then
    self.config:get "on_config_done"(project)
  end
end

return M

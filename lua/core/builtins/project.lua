local M = {
  defaults = {
    ---@usage set to false to disable project.nvim.
    --- This is on by default since it's currently the expected behavior.
    active = true,

    on_config_done = nil,

    config = {
      ---@type string
      ---@usage path to store the project history for use in telescope
      datapath = CACHE_PATH,
    },
  },
}

function M:setup(config)
  config:merge(self.defaults)
end

function M:configure()
  local project = require "project_nvim"

  project.setup(lvim.builtins.project.config)
  if lvim.builtins.project.on_config_done then
    lvim.builtins.project.on_config_done(project)
  end
end

return M

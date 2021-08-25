local M = {}

function M.config()
  lvim.builtin.project = {
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
end

function M.setup()
  local project = require "project_nvim"

  project.setup(lvim.builtin.project.config)
  if lvim.builtin.project.on_config_done then
    lvim.builtin.project.on_config_done(project)
  end
end

return M

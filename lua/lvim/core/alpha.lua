local M = {}

local lvim_dashboard = require "lvim.core.alpha.dashboard"
local lvim_startify = require "lvim.core.alpha.startify"
function M.config()
  lvim.builtin.alpha = {
    dashboard = lvim_dashboard.config(),
    startify = lvim_startify.config(),
    active = true,
    mode = "dashboard",
  }
end

function M.setup()
  if lvim.builtin.alpha.mode == "dashboard" then
    lvim_dashboard.setup(lvim.builtin.alpha.dashboard)
  else
    lvim_startify.setup(lvim.builtin.alpha.startify)
  end
end

return M

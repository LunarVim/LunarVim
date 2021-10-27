local M = {}

local Log = require "lvim.core.log"

local defaults = {
  active = false,
  on_config_done = nil,
  opts = {
    ---@usage Animation style one of { "fade", "slide", "fade_in_slide_out", "static" }
    stages = "slide",

    ---@usage timeout for notifications in ms, default 5000
    timeout = 5000,

    ---@usage highlight behind the window for stages that change opacity
    background_colour = "#abb2bf",

    ---@usage Icons for the different levels
    icons = {
      ERROR = "",
      WARN = "",
      INFO = "",
      DEBUG = "",
      TRACE = "✎",
    },
  },
}

function M.config()
  lvim.builtin.notify = vim.tbl_deep_extend("force", defaults, lvim.builtin.notify or {})
end

function M.setup()
  local opts = lvim.builtin.notify and lvim.builtin.notify.opts or defaults
  local notify = require "notify"

  notify.setup(opts)
  Log:configure_notifications(notify)
end

return M

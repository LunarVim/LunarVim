local M = {}

function M.config()
  local pallete = require "onedarker.palette"
  lvim.builtin.notify = {
    active = false,
    on_config_done = nil,
    -- TODO: update after https://github.com/rcarriga/nvim-notify/pull/24
    opts = {
      ---@usage Animation style (see below for details)
      stages = "fade_in_slide_out",

      ---@usage Default timeout for notifications
      timeout = 5000,

      ---@usage For stages that change opacity this is treated as the highlight behind the window
      background_colour = pallete.fg,

      ---@usage Icons for the different levels
      icons = {
        ERROR = "",
        WARN = "",
        INFO = "",
        DEBUG = "",
        TRACE = "✎",
      },
    },
  }
end

return M

local M = {}

function M.config()
  lvim.builtin.notify = {
    active = false,
    on_config_done = nil,
    opts = {
      ---@usage Animation style (see below for details)
      stages = "fade_in_slide_out",

      ---@usage Default timeout for notifications
      timeout = 5000,

      ---@usage For stages that change opacity this is treated as the highlight behind the window
      -- Set this to either a highlight group or an RGB hex value e.g. "#000000"
      background_colour = "Normal",

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

function M.setup() end

return M

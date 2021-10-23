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

M.params_injecter = function(_, entry)
  local logger = Log:get_logger()
  for key, value in pairs(logger.context) do
    entry[key] = value
  end
  return entry
end

M.default_namer = function(_, entry)
  entry["title"] = entry.title or "lvim"
  return entry
end

function M.setup_logger_sink()
  local status_ok, structlog = pcall(require, "structlog")
  if not status_ok then
    return nil
  end
  M.params_injecter(nil, {})

  Log:configure_sink(
    "NvimNotify",
    structlog.sinks.NvimNotify:new(Log.levels.INFO, {
      processors = {
        M.default_namer,
        M.params_injecter,
      },
      formatter = structlog.formatters.Format( --
        "%s",
        { "msg" },
        { blacklist_all = true }
      ),
      params_map = {
        icon = "icon",
        keep = "keep",
        on_open = "on_open",
        on_close = "on_close",
        timeout = "timeout",
        title = "title",
      },
    })
  )
end

function M.setup()
  local opts = lvim.builtin.notify and lvim.builtin.notify.opts or defaults
  require("notify").setup(opts)
  M.setup_logger_sink()
end

return M

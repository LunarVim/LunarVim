local Log = {}

local logfile = string.format("%s/%s.log", vim.fn.stdpath "cache", "lvim")

Log.levels = {
  TRACE = 1,
  DEBUG = 2,
  INFO = 3,
  WARN = 4,
  ERROR = 5,
}

vim.tbl_add_reverse_lookup(Log.levels)

function Log:init()
  local status_ok, structlog = pcall(require, "structlog")
  if not status_ok then
    return nil
  end

  local log_level = Log.levels[(lvim.log.level):upper() or "WARN"]
  structlog.configure {
    lvim = {
      level = log_level,
      sinks = {
        structlog.sinks.Console {
          async = false,
          processors = {
            structlog.processors.Namer(),
            structlog.processors.StackWriter({ "line", "file" }, { max_parents = 0, stack_level = 2 }),
            structlog.processors.Timestamper "%H:%M:%S",
          },
          formatter = structlog.formatters.FormatColorizer( --
            "%s [%s] %s: %-30s",
            { "timestamp", "level", "logger_name", "msg" },
            { level = structlog.formatters.FormatColorizer.color_level() }
          ),
        },
        structlog.sinks.File(logfile, {
          processors = {
            structlog.processors.Namer(),
            structlog.processors.StackWriter({ "line", "file" }, { max_parents = 3, stack_level = 2 }),
            structlog.processors.Timestamper "%H:%M:%S",
          },
          formatter = structlog.formatters.Format( --
            "%s [%s] %s: %-30s",
            { "timestamp", "level", "logger_name", "msg" }
          ),
        }),
      },
    },
  }

  return structlog.get_logger "lvim"
end

--- Adds a log entry using Plenary.log
---@fparam msg any
---@param level string [same as vim.log.log_levels]
function Log:add_entry(level, msg, event)
  if self.__handle then
    self.__handle:log(level, msg, event)
  end

  local logger = self:init()
  if not logger then
    return
  end

  self.__handle = logger
  self.__handle:log(level, msg, event)
end

---Retrieves the path of the logfile
---@return string path of the logfile
function Log:get_path()
  return logfile
end

---Add a log entry at TRACE level
---@param msg any
---@param event any
function Log:trace(msg, event)
  self:add_entry(self.levels.TRACE, msg, event)
end

---Add a log entry at DEBUG level
---@param msg any
---@param event any
function Log:debug(msg, event)
  self:add_entry(self.levels.DEBUG, msg, event)
end

---Add a log entry at INFO level
---@param msg any
---@param event any
function Log:info(msg, event)
  self:add_entry(self.levels.INFO, msg, event)
end

---Add a log entry at WARN level
---@param msg any
---@param event any
function Log:warn(msg, event)
  self:add_entry(self.levels.WARN, msg, event)
end

---Add a log entry at ERROR level
---@param msg any
---@param event any
function Log:error(msg, event)
  self:add_entry(self.levels.ERROR, msg, event)
end

setmetatable({}, Log)

return Log

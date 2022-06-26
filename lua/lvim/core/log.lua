local Log = {}

Log.levels = {
  TRACE = 1,
  DEBUG = 2,
  INFO = 3,
  WARN = 4,
  ERROR = 5,
}
vim.tbl_add_reverse_lookup(Log.levels)

local notify_opts = {}

function Log:set_level(level)
  local logger_ok, _ = xpcall(function()
    local log_level = Log.levels[level:upper()]
    local structlog = require "structlog"
    if structlog then
      local logger = structlog.get_logger "lvim"
      for _, s in ipairs(logger.sinks) do
        s.level = log_level
      end
    end
  end, debug.traceback)
  if not logger_ok then
    Log:debug("Unable to set logger's level: " .. debug.traceback())
  end

  local packer_ok, _ = xpcall(function()
    package.loaded["packer.log"] = nil
    require("packer.log").new { level = lvim.log.level }
  end, debug.traceback)
  if not packer_ok then
    Log:debug("Unable to set packer's log level: " .. debug.traceback())
  end
end

function Log:init()
  local status_ok, structlog = pcall(require, "structlog")
  if not status_ok then
    return nil
  end

  local log_level = Log.levels[(lvim.log.level):upper() or "WARN"]
  local lvim_log = {
    lvim = {
      sinks = {
        structlog.sinks.Console(log_level, {
          async = true,
          processors = {
            structlog.processors.Namer(),
            structlog.processors.StackWriter({ "line", "file" }, { max_parents = 0, stack_level = 2 }),
            structlog.processors.Timestamper "%H:%M:%S",
          },
          formatter = structlog.formatters.FormatColorizer( --
            "%s [%-5s] %s: %-30s",
            { "timestamp", "level", "logger_name", "msg" },
            { level = structlog.formatters.FormatColorizer.color_level() }
          ),
        }),
        structlog.sinks.File(log_level, self:get_path(), {
          processors = {
            structlog.processors.Namer(),
            structlog.processors.StackWriter({ "line", "file" }, { max_parents = 3, stack_level = 2 }),
            structlog.processors.Timestamper "%F %H:%M:%S",
          },
          formatter = structlog.formatters.Format( --
            "%s [%-5s] %s: %-30s",
            { "timestamp", "level", "logger_name", "msg" }
          ),
        }),
      },
    },
  }

  structlog.configure(lvim_log)
  local logger = structlog.get_logger "lvim"

  -- Overwrite `vim.notify` to use the logger
  if lvim.log.override_notify then
    vim.notify = function(msg, vim_log_level, opts)
      notify_opts = opts or {}

      -- vim_log_level can be omitted
      if vim_log_level == nil then
        vim_log_level = Log.levels["INFO"]
      elseif type(vim_log_level) == "string" then
        vim_log_level = Log.levels[(vim_log_level):upper()] or Log.levels["INFO"]
      else
        -- https://github.com/neovim/neovim/blob/685cf398130c61c158401b992a1893c2405cd7d2/runtime/lua/vim/lsp/log.lua#L5
        vim_log_level = vim_log_level + 1
      end

      logger:log(vim_log_level, msg)
    end
  end

  return logger
end

--- Configure the sink in charge of logging notifications
---@param notif_handle table The implementation used by the sink for displaying the notifications
function Log:configure_notifications(notif_handle)
  local status_ok, structlog = pcall(require, "structlog")
  if not status_ok then
    return
  end

  local default_namer = function(logger, entry)
    entry["title"] = logger.name
    return entry
  end

  local notify_opts_injecter = function(_, entry)
    for key, value in pairs(notify_opts) do
      entry[key] = value
    end
    notify_opts = {}
    return entry
  end

  local sink = structlog.sinks.NvimNotify(Log.levels.INFO, {
    processors = {
      default_namer,
      notify_opts_injecter,
    },
    formatter = structlog.formatters.Format( --
      "%s",
      { "msg" },
      { blacklist_all = true }
    ),
    -- This should probably not be hard-coded
    params_map = {
      icon = "icon",
      keep = "keep",
      on_open = "on_open",
      on_close = "on_close",
      timeout = "timeout",
      title = "title",
    },
    impl = notif_handle,
  })

  table.insert(self.__handle.sinks, sink)
end

--- Adds a log entry using Plenary.log
---@param msg any
---@param level string [same as vim.log.log_levels]
function Log:add_entry(level, msg, event)
  local logger = self:get_logger()
  if not logger then
    return
  end
  logger:log(level, vim.inspect(msg), event)
end

---Retrieves the handle of the logger object
---@return table|nil logger handle if found
function Log:get_logger()
  if self.__handle then
    return self.__handle
  end

  local logger = self:init()
  if not logger then
    return
  end

  self.__handle = logger
  return logger
end

---Retrieves the path of the logfile
---@return string path of the logfile
function Log:get_path()
  return string.format("%s/%s.log", get_cache_dir(), "lvim")
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

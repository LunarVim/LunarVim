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
local log_notify_as_notification = false

function Log:set_level(level)
  if
    not pcall(function()
      local logger_ok, logger = pcall(function()
        return require("structlog").get_logger "lvim"
      end)
      local log_level = Log.levels[level:upper()]
      if logger_ok and logger and log_level then
        for _, pipeline in ipairs(logger.pipelines) do
          pipeline.level = log_level
        end
      end
    end)
  then
    vim.notify "structlog version too old, run `:Lazy sync`"
  end
end

function Log:init()
  local status_ok, structlog = pcall(require, "structlog")
  if not status_ok then
    return nil
  end

  local log_level = Log.levels[(lvim.log.level):upper() or "WARN"]
  structlog.configure {
    lvim = {
      pipelines = {
        {
          level = log_level,
          processors = {
            structlog.processors.StackWriter({ "line", "file" }, { max_parents = 0, stack_level = 2 }),
            structlog.processors.Timestamper "%H:%M:%S",
          },
          formatter = structlog.formatters.FormatColorizer(
            "%s [%-5s] %s: %-30s",
            { "timestamp", "level", "logger_name", "msg" },
            { level = structlog.formatters.FormatColorizer.color_level() }
          ),
          sink = structlog.sinks.Console(false), -- async=false
        },
        {
          level = log_level,
          processors = {
            structlog.processors.StackWriter({ "line", "file" }, { max_parents = 3, stack_level = 2 }),
            structlog.processors.Timestamper "%F %H:%M:%S",
          },
          formatter = structlog.formatters.Format(
            "%s [%-5s] %s: %-30s",
            { "timestamp", "level", "logger_name", "msg" }
          ),
          sink = structlog.sinks.File(self:get_path()),
        },
      },
    },
  }

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

      self:add_entry(vim_log_level, msg)
    end
  end

  return logger
end

--- Configure the sink in charge of logging notifications
---@param nvim_notify table The nvim-notify instance
function Log:configure_notifications(nvim_notify)
  local status_ok, structlog = pcall(require, "structlog")
  if not status_ok then
    return
  end

  local function log_writer(log)
    local opts = { title = log.logger_name }
    opts = vim.tbl_deep_extend("force", opts, notify_opts)
    notify_opts = {}

    if log_notify_as_notification then
      nvim_notify(log.msg, log.level, opts)
    end
  end

  local notif_pipeline = structlog.Pipeline(
    structlog.level.INFO,
    {},
    structlog.formatters.Format("%s", { "msg" }, { blacklist_all = true }),
    structlog.sinks.Adapter(log_writer)
  )
  self.__handle:add_pipeline(notif_pipeline)
end

--- Adds a log entry using Plenary.log
---@param level integer [same as vim.log.levels]
---@param msg any
---@param event any
function Log:add_entry(level, msg, event)
  if
    not pcall(function()
      local logger = self:get_logger()
      if not logger then
        return
      end
      logger:log(level, vim.inspect(msg), event)
    end)
  then
    vim.notify "structlog version too old, run `:Lazy sync`"
  end
end

---Retrieves the handle of the logger object
---@return table|nil logger handle if found
function Log:get_logger()
  local logger_ok, logger = pcall(function()
    return require("structlog").get_logger "lvim"
  end)
  if logger_ok and logger then
    return logger
  end

  logger = self:init()

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

local Log = {
  level = "INFO",
}

local function configure_handle(level)
  local status_ok, plenary = pcall(require, "plenary")
  if not status_ok then
    return nil
  end

  local default_opts = { plugin = "lunarvim", level = level }
  return plenary.log.new(default_opts)
end

--- Configure the logger instance.
-- @param config The configuration of the logger
function Log:config(config)
  self.level = config:get "level"
  self.__handle = configure_handle(self.level:lower())
end

--- Adds a log entry using Plenary.log
---@param msg any
---@param level string [same as vim.log.log_levels]
function Log:add_entry(msg, level)
  assert(type(level) == "string")
  if not self.__handle then
    self.__handle = configure_handle(self.level:lower())
  end
  if self.__handle then
    -- plenary uses lower-case log levels
    self.__handle[level:lower()](msg)
  end
  -- don't do anything if plenary is not available
end

---Retrieves the path of the logfile
---@return string path of the logfile
function Log:get_path()
  return string.format("%s/%s.log", vim.fn.stdpath "cache", "lunarvim")
end

---Add a log entry at TRACE level
---@param msg any
function Log:trace(msg)
  self:add_entry(msg, "TRACE")
end

---Add a log entry at DEBUG level
---@param msg any
function Log:debug(msg)
  self:add_entry(msg, "DEBUG")
end

---Add a log entry at INFO level
---@param msg any
function Log:info(msg)
  self:add_entry(msg, "INFO")
end

---Add a log entry at WARN level
---@param msg any
function Log:warn(msg)
  self:add_entry(msg, "WARN")
end

---Add a log entry at ERROR level
---@param msg any
function Log:error(msg)
  self:add_entry(msg, "ERROR")
end

setmetatable({}, Log)
return Log

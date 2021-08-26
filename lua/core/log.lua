local Log = {}

--- Creates a log handle based on Plenary.log
---@param opts these are passed verbatim to Plenary.log
---@return log handle
function Log:new(opts)
  local status_ok, handle = pcall(require, "plenary.log")
  if not status_ok then
    vim.notify("Plenary.log is not available. Logging to console only", vim.log.levels.DEBUG)
  end

  self.__handle = handle

  local path = string.format("%s/%s.log", vim.api.nvim_call_function("stdpath", { "cache" }), opts.plugin)

  self.get_path = function()
    return path
  end

  setmetatable({}, Log)
  return self
end

function Log:add_entry(msg, level)
  local status_ok, _ = pcall(require, "plenary.log")
  if status_ok then
    -- plenary uses lower-case log levels
    return self.__handle[level:lower()](msg)
  end
  -- don't do anything if plenary is not available
end

--- Creates or retrieves a log handle for the default logfile
--- based on Plenary.log
---@return log handle
function Log:new_default()
  return Log:new { plugin = "lunarvim", level = lvim.log.level }
end

function Log:trace(msg)
  self:add_entry(msg, "TRACE")
end

function Log:debug(msg)
  self:add_entry(msg, "DEBUG")
end

function Log:info(msg)
  self:add_entry(msg, "INFO")
end

function Log:warn(msg)
  self:add_entry(msg, "TRACE")
end

function Log:error(msg)
  self:add_entry(msg, "TRACE")
end

return Log

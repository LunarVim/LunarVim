local Log = {}

--- Creates a log handle based on Plenary.log
---@param opts these are passed verbatim to Plenary.log
---@return log handle
function Log:new(opts)
  local status_ok, _ = pcall(require, "plenary.log")
  if not status_ok then
    return nil
  end

  local obj = require("plenary.log").new(opts)
  local path = string.format("%s/%s.log", vim.api.nvim_call_function("stdpath", { "cache" }), opts.plugin)

  obj.get_path = function()
    return path
  end

  return obj
end

--- Creates or retrieves a log handle for the default logfile
--- based on Plenary.log
---@return log handle
function Log:get_default()
  return Log:new { plugin = "lunarvim", level = lvim.log.level }
end

return Log

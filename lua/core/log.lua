local Log = {}

--- Creates a log handle based on Plenary.log
---@param opts these are passed verbatim to Plenary.log
---@return log handle
function Log:new(opts)
  if vim.fn.executable(lvim.log.viewer) ~= 1 then
    lvim.log.viewer = "less +F"
  end

  opts = opts or {}

  setmetatable({
    plugin = opts.plugin,
    level = opts.level,
  }, Log)
  return require("plenary.log").new(opts)
end

--- Creates or retrieves a log handle for the default logfile
--- based on Plenary.log
---@return log handle
function Log:get_default()
  return Log:new { plugin = "lunarvim", level = lvim.log.level }
end

return Log

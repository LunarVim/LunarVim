local M = {}

---@usage creates a log
---@param opts same as "plenary.log"
---@return log handle
function M.new(opts)
  opts = opts or {}
  return require("plenary.log").new(opts)
end

---@usage retrieves the shared default log
---@return log handle
function M.get_default()
  return require("plenary.log").new {
    plugin = "lunarvim",
    level = (lvim.debug and "debug") or "warn",
  }
end

return M

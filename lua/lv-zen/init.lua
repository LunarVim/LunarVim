local M = {}
local status_ok, zen_mode = pcall(require, "zen-mode")
if not status_ok then
  return
end

M.config = function()
  zen_mode.setup(O.plugin.zen)
end
return M

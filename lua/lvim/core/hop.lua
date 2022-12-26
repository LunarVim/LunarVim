local M = {}

M.config = function()
  lvim.builtin.hop = {
    active = true
  }
end

M.setup = function()
  local ok, hop = pcall(require, 'hop')
  if not ok then
    return
  end
  hop.setup()
end

return M

local M = {}

M.config = function()
  vim.g.matchup_matchparen_offscreen = { method = "popup" }
end

return M

local M = {}

M.setup = function()
  local lspinstall = require "lspinstall"
  lspinstall.setup()
  return lspinstall
end

return M

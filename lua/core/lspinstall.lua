local M = {
  name = "lspinstall",
}

M.setup = function()
  local lspinstall = require "lspinstall"
  lspinstall.setup()
  return lspinstall
end

return M

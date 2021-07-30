local M = {}

M.config = function()
  lvim.builtin.lspinstall = {
    active = true,
    on_config_done = nil,
  }
end

M.setup = function()
  local lspinstall = require "lspinstall"
  lspinstall.setup()

  if lvim.builtin.lspinstall.on_config_done then
    lvim.builtin.lspinstall.on_config_done(lspinstall)
  end

  return lspinstall
end

return M

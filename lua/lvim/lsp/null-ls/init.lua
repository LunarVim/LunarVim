local M = {}

local Log = require "lvim.core.log"

function M:setup()
  local status_ok, null_ls = pcall(require, "null-ls")
  if not status_ok then
    Log:error "Missing null-ls dependency"
    return
  end

  null_ls.setup(lvim.lsp.null_ls.config)
end

return M

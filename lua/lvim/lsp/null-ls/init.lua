local M = {}

local Log = require "lvim.core.log"

function M:setup()
  local status_ok, null_ls = pcall(require, "null-ls")
  if not status_ok then
    Log:error "Missing null-ls dependency"
    return
  end

  null_ls.config(lvim.lsp.null_ls.config)
  local default_opts = require("lvim.lsp").get_common_opts()

  if vim.tbl_isempty(lvim.lsp.null_ls.setup or {}) then
    lvim.lsp.null_ls.setup = default_opts
  end

  require("lspconfig")["null-ls"].setup(lvim.lsp.null_ls.setup)
end

return M

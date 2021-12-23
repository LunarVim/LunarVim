-- Set Default Prefix.
-- Note: You can set a prefix per lsp server in the lv-globals.lua file
local M = {}

function M.setup()
  local config = { -- your config
    virtual_text = lvim.lsp.diagnostics.virtual_text,
    signs = lvim.lsp.diagnostics.signs,
    underline = lvim.lsp.diagnostics.underline,
    update_in_insert = lvim.lsp.diagnostics.update_in_insert,
    severity_sort = lvim.lsp.diagnostics.severity_sort,
    float = lvim.lsp.diagnostics.float,
  }
  vim.diagnostic.config(config)
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, lvim.lsp.float)
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, lvim.lsp.float)
end

function M.show_line_diagnostics()
  local config = lvim.lsp.diagnostics.float
  config.scope = "line"
  return vim.diagnostic.open_float(0, config)
end

return M

-- Set Default Prefix.
-- Note: You can set a prefix per lsp server in the lv-globals.lua file
local M = {}

local default_diagnostic_config = {
  signs = {
    active = true,
    values = {
      { name = "DiagnosticSignError", text = lvim.icons.diagnostics.Error },
      { name = "DiagnosticSignWarn", text = lvim.icons.diagnostics.Warning },
      { name = "DiagnosticSignHint", text = lvim.icons.diagnostics.Hint },
      { name = "DiagnosticSignInfo", text = lvim.icons.diagnostics.Information },
    },
  },
  virtual_text = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
    format = function(d)
      local code = d.code or (d.user_data and d.user_data.lsp.code)
      if code then
        return string.format("%s [%s]", d.message, code):gsub("1. ", "")
      end
      return d.message
    end,
  },
}

function M.load_defaults()
  vim.diagnostic.config(default_diagnostic_config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, lvim.lsp.handlers)
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, lvim.lsp.handlers)
end

return M

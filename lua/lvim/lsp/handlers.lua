-- Set Default Prefix.
-- Note: You can set a prefix per lsp server in the lv-globals.lua file
local M = {}

function M.setup()
  vim.diagnostic.config(lvim.lsp.diagnostics.config)
end

function M.show_line_diagnostics()
  local config = lvim.lsp.diagnostics.config
  config.scope = "line"
  return vim.diagnostic.open_float(0, config)
end

return M

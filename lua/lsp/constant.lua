local M = {}

M.completion_item_kind = {
  "   (Text) ",
  "   (Method)",
  "   (Function)",
  "   (Constructor)",
  " ﴲ  (Field)",
  "[] (Variable)",
  "   (Class)",
  " ﰮ  (Interface)",
  "   (Module)",
  " 襁 (Property)",
  "   (Unit)",
  "   (Value)",
  " 練 (Enum)",
  "   (Keyword)",
  "   (Snippet)",
  "   (Color)",
  "   (File)",
  "   (Reference)",
  "   (Folder)",
  "   (EnumMember)",
  " ﲀ  (Constant)",
  " ﳤ  (Struct)",
  "   (Event)",
  "   (Operator)",
  "   (TypeParameter)",
}

M.signs = {
  { name = "LspDiagnosticsSignError", text = "" },
  { name = "LspDiagnosticsSignWarning", text = "" },
  { name = "LspDiagnosticsSignHint", text = "" },
  { name = "LspDiagnosticsSignInformation", text = "" },
}

M.mappings = {
  normal_mode = {
    { "gd", "<cmd>lua vim.lsp.buf.definition()<CR>" },
    { "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>" },
    { "gr", "<cmd>lua vim.lsp.buf.references()<CR>" },
    { "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>" },
    { "gl", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ show_header = false, border = 'single' })<CR>" },
    { "gp", "<cmd>lua require'lsp'.PeekDefinition()<CR>" },
    { "K", "<cmd>lua vim.lsp.buf.hover()<CR>" },
    { "<C-p>", "<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = lvim.lsp.popup_border}})<CR>" },
    { "<C-n>", "<cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {border = lvim.lsp.popup_border}})<CR>" },
    -- { "<tab>", "<cmd>lua vim.lsp.buf.signature_help()<CR>" },
  },
}

M.augroups = {
  _general_lsp = {
    { "FileType", "lspinfo", "nnoremap <silent> <buffer> q :q<CR>" },
  },
}

-- local opts = { border = "single" }
-- TODO revisit this
-- local border = {
--   { "🭽", "FloatBorder" },
--   { "▔", "FloatBorder" },
--   { "🭾", "FloatBorder" },
--   { "▕", "FloatBorder" },
--   { "🭿", "FloatBorder" },
--   { "▁", "FloatBorder" },
--   { "🭼", "FloatBorder" },
--   { "▏", "FloatBorder" },
-- }

-- My font didn't like this :/
-- vim.api.nvim_set_keymap(
--   "n",
--   "gl",
--   '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ show_header = false, border = { { "🭽", "FloatBorder" }, { "▔", "FloatBorder" }, { "🭾", "FloatBorder" }, { "▕", "FloatBorder" }, { "🭿", "FloatBorder" }, { "▁", "FloatBorder" }, { "🭼", "FloatBorder" }, { "▏", "FloatBorder" }, } })<CR>',
--   { noremap = true, silent = true }
-- )

return M

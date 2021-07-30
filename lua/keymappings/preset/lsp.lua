local lsp = {}

-- local opt = { noremap = true, silent = true }
--
lsp.normal_mode = {}
--
-- lsp.normal_mode["gd"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", opt }
-- lsp.normal_mode["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<CR>", opt }
-- lsp.normal_mode["gr"] = { "<cmd>lua vim.lsp.buf.references()<CR>", opt }
-- lsp.normal_mode["gi"] = { "<cmd>lua vim.lsp.buf.implementation()<CR>", opt }
-- lsp.normal_mode["gl"] = {
--   '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ show_header = false, border = "single" })<CR>',
--   opt,
-- }
-- lsp.normal_mode["gp"] = { "<cmd>lua require'lsp'.PeekDefinition()<CR>", opt }
-- lsp.normal_mode["K"] = { ":lua vim.lsp.buf.hover()<CR>", opt }
-- lsp.normal_mode["<C-p>"] = {
--   ":lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = O.lsp.popup_border}})<CR>",
--   opt,
-- }
-- lsp.normal_mode["<C-n>"] = {
--   ":lua vim.lsp.diagnostic.goto_next({popup_opts = {border = O.lsp.popup_border}})<CR>",
--   opt,
-- }
-- lsp.normal_mode["<tab>"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", opt }

return lsp

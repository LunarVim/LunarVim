require("lsp").setup(O.lang.vim.lsp.provider, O.lang.vim.lsp.setup)

require("lint").linters_by_ft = {
  vim = O.lang.vim.linters,
}

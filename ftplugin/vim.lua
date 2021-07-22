require("lsp").setup(O.lang.vim.lsp)

require("lint").linters_by_ft = {
  vim = O.lang.vim.linters,
}

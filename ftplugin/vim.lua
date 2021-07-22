require("lsp").setup("vimls", {
  O.lang.vim.lsp.path,
  "--stdio",
})

require("lint").linters_by_ft = {
  vim = O.lang.vim.linters,
}

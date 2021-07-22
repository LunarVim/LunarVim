require("core.formatter").setup "html"

require("lsp").setup(O.lang.html.lsp)

require("lint").linters_by_ft = {
  html = O.lang.html.linters,
}

require("core.formatter").setup "html"

require("lsp").setup(O.lang.html.lsp.provider, O.lang.html.lsp.setup)

require("lint").linters_by_ft = {
  html = O.lang.html.linters,
}

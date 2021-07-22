require("core.formatter").setup "html"

require("lsp").setup("html", {
  "node",
  O.lang.html.lsp.path,
  "--stdio",
})

require("lint").linters_by_ft = {
  html = O.lang.html.linters,
}

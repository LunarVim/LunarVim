require("core.formatter").setup "go"

require("lint").linters_by_ft = {
  go = O.lang.go.linters,
}

require("lsp").setup("gopls", {
  O.lang.go.lsp.path,
})

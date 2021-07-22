require("core.formatter").setup "go"

require("lint").linters_by_ft = {
  go = O.lang.go.linters,
}

require("lsp").setup(O.lang.go.lsp.provider, O.lang.go.lsp.setup)

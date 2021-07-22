require("core.formatter").setup "sh"

require("lint").linters_by_ft = {
  sh = O.lang.sh.linters,
}

require("lsp").setup("bashls", {
  O.lang.sh.lsp.path,
  "start",
})

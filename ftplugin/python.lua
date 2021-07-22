require("core.formatter").setup "python"

require("lsp").setup("pyright", {
  O.lang.python.lsp.path,
  "--stdio",
})

require("lint").linters_by_ft = {
  python = O.lang.python.linters,
}

-- TODO get from dap
-- require("lang.python").dap()

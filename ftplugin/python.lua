require("core.formatter").setup "python"

require("lsp").setup(O.lang.python.lsp.provider, O.lang.python.lsp.setup)

require("lint").linters_by_ft = {
  python = O.lang.python.linters,
}

-- TODO get from dap
-- require("lang.python").dap()

O.formatters.filetype["cpp"] = O.formatters.filetype["c"]
O.formatters.filetype["objc"] = O.formatters.filetype["c"]
require("core.formatter").setup "c"

require("lsp").setup(O.lang.c.lsp)

require("lint").linters_by_ft = {
  c = O.lang.c.linters,
  cpp = O.lang.c.linters,
}

-- TODO get from dap
-- require("lang.c").dap()

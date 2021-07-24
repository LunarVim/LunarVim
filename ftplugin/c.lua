O.formatters.filetype["cpp"] = O.formatters.filetype["c"]
O.formatters.filetype["objc"] = O.formatters.filetype["c"]
require("core.formatter").setup "c"

require("lsp").setup(O.lang.c.lsp)

-- TODO get from dap
-- require("lang.c").dap()

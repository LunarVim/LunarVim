-- require("core.formatter").setup "python"

require("lsp").setup(O.lang.python.lsp)
require("lsp.null-ls").setup "python"

-- require("lint").linters_by_ft = {
--   python = O.lang.python.linters,
-- }

-- TODO get from dap
-- require("lang.python").dap()

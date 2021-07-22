require("core.formatter").setup "rust"

require("lsp").setup(O.lang.rust.lsp.provider, O.lang.rust.lsp.setup)

-- TODO get from dap
-- require("lang.rust").dap()

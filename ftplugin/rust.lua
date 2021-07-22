require("core.formatter").setup "rust"

require("lsp").setup("rust_analyzer", {
  O.lang.rust.lsp.path,
})

-- TODO get from dap
-- require("lang.rust").dap()

require("core.formatter").setup "zig"

require("lsp").setup("zls", {
  O.lang.zig.lsp.path,
})

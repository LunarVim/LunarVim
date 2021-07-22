require("core.formatter").setup "zig"

require("lsp").setup(O.lang.zig.lsp.provider, O.lang.zig.lsp.setup)

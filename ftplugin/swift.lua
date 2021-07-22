require("core.formatter").setup "swift"
require("lsp").setup("sourcekit", {
  "xcrun",
  O.lang.swift.lsp.path,
})

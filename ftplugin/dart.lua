require("core.formatter").setup "dart"

require("lsp").setup("dartls", {
  "dart",
  O.lang.dart.sdk_path,
  "--lsp",
})

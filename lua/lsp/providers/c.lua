local opts = {
  formatters = {},
  linters = {},
  lsp = {
    provider = "clangd",
    setup = {
      cmd = {
        lvim.lsp.ls_install_prefix .. "/cpp/clangd/bin/clangd",
        "--background-index",
        "--header-insertion=never",
        "--cross-file-rename",
        "--clang-tidy",
        "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*",
      },
    },
  },
}
return opts

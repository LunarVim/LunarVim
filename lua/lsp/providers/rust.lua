local opts = {
  formatters = {},
  linters = {},
  lsp = {
    provider = "rust_analyzer",
    setup = {
      cmd = { lvim.lsp.ls_install_prefix .. "/rust/rust-analyzer" },
    },
  },
}
return opts

local opts = {
  formatters = {},
  linters = {},
  lsp = {
    provider = "hls",
    setup = {
      cmd = { lvim.lsp.ls_install_prefix .. "/haskell/hls" },
    },
  },
}
return opts

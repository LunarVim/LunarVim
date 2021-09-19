local opts = {
  formatters = {},
  linters = {},
  lsp = {
    provider = "gopls",
    setup = {
      cmd = { lvim.lsp.ls_install_prefix .. "/go/gopls" },
    },
  },
}
return opts

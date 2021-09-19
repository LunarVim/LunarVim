local opts = {
  formatters = {},
  linters = {},
  lsp = {
    provider = "texlab",
    setup = {
      cmd = { lvim.lsp.ls_install_prefix .. "/latex/texlab" },
    },
  },
}
return opts

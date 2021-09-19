local opts = {
  formatters = {},
  linters = {},
  lsp = {
    provider = "jdtls",
    setup = {
      cmd = { lvim.lsp.ls_install_prefix .. "/java/jdtls.sh" },
    },
  },
}
return opts

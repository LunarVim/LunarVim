local opts = {
  formatters = {},
  linters = {},
  lsp = {
    provider = "puppet",
    setup = {
      cmd = { lvim.lsp.ls_install_prefix .. "/puppet/puppet-editor-services/puppet-languageserver", "--stdio" },
    },
  },
}
return opts

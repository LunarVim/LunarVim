local opts = {
  formatters = {},
  linters = {},
  lsp = {
    provider = "yamlls",
    setup = {
      cmd = { lvim.lsp.ls_install_prefix .. "/yaml/node_modules/.bin/yaml-language-server", "--stdio" },
    },
  },
}
return opts

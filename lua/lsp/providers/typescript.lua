local opts = {
  formatters = {},
  linters = {},
  lsp = {
    provider = "tsserver",
    setup = {
      cmd = { lvim.lsp.ls_install_prefix .. "/typescript/node_modules/.bin/typescript-language-server", "--stdio" },
    },
  },
}
return opts

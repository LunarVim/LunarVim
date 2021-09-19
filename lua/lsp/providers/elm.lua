local opts = {
  formatters = {},
  linters = {},
  lsp = {
    provider = "elmls",
    setup = {
      cmd = { lvim.lsp.ls_install_prefix .. "/elm/node_modules/.bin/elm-language-server" },
    },
  },
}
return opts

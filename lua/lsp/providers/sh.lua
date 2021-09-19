local opts = {
  formatters = {},
  linters = {},
  lsp = {
    provider = "bashls",
    setup = {
      cmd = { lvim.lsp.ls_install_prefix .. "/bash/node_modules/.bin/bash-language-server", "start" },
    },
  },
}
return opts

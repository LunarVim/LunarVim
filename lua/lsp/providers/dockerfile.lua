local opts = {
  formatters = {},
  linters = {},
  lsp = {
    provider = "dockerls",
    setup = {
      cmd = { lvim.lsp.ls_install_prefix .. "/dockerfile/node_modules/.bin/docker-langserver", "--stdio" },
    },
  },
}
return opts

local opts = {
  formatters = {},
  linters = {},
  lsp = {
    provider = "pyright",
    setup = {
      cmd = { lvim.lsp.ls_install_prefix .. "/python/node_modules/.bin/pyright-langserver", "--stdio" },
    },
  },
}
return opts

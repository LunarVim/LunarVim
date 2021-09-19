local opts = {
  formatters = {},
  linters = {},
  lsp = {
    provider = "intelephense",
    setup = {
      cmd = { lvim.lsp.ls_install_prefix .. "/php/node_modules/.bin/intelephense", "--stdio" },
      filetypes = { "php", "phtml" },
      settings = {
        intelephense = {
          environment = {
            phpVersion = "7.4",
          },
        },
      },
    },
  },
}
return opts

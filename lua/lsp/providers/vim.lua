local opts = {
  formatters = {},
  linters = {},
  lsp = {
    provider = "vimls",
    setup = {
      cmd = { lvim.lsp.ls_install_prefix .. "/vim/node_modules/.bin/vim-language-server", "--stdio" },
    },
  },
}
return opts

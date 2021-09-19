local opts = {
  formatters = {},
  linters = {},
  lsp = {
    provider = "cmake",
    setup = {
      cmd = { lvim.lsp.ls_install_prefix .. "/cmake/venv/bin/cmake-language-server" },
    },
  },
}
return opts

local opts = {
  formatters = {},
  linters = {},
  lsp = {
    provider = "fortls",
    setup = {
      cmd = { lvim.lsp.ls_install_prefix .. "/fortran/venv/bin/fortls" },
    },
  },
}
return opts

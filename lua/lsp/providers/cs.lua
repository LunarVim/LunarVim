local opts = {
  formatters = {},
  linters = {},
  lsp = {
    provider = "omnisharp",
    setup = {
      cmd = { lvim.lsp.ls_install_prefix .. "/csharp/omnisharp/run", "--languageserver", "--hostPID", "7281" },
    },
  },
}
return opts

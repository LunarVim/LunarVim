local opts = {
  formatters = {},
  linters = {},
  lsp = {
    provider = "bicep",
    setup = {
      cmd = { "dotnet", lvim.lsp.ls_install_prefix .. "/bicep/Bicep.LangServer.dll" },
      filetypes = { "bicep" },
    },
  },
}
return opts

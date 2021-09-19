local opts = {
  formatters = {},
  linters = {},
  lsp = {
    provider = "terraformls",
    setup = {
      cmd = { lvim.lsp.ls_install_prefix .. "/terraform/terraform-ls", "serve" },
    },
  },
}
return opts

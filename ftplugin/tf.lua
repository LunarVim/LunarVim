O.formatters.filetype["hcl"] = {
  function()
    return {
      exe = O.lang.terraform.formatter.exe,
      args = O.lang.terraform.formatter.args,
      stdin = not (O.lang.terraform.formatter.stdin ~= nil),
    }
  end,
}
O.formatters.filetype["tf"] = O.formatters.filetype["hcl"]

require("formatter.config").set_defaults {
  logging = false,
  filetype = O.formatters.filetype,
}

if require("lv-utils").check_lsp_client_active "terraformls" then
  return
end

require("lspconfig").terraformls.setup {
  cmd = { DATA_PATH .. "/lspinstall/terraform/terraform-ls", "serve" },
  on_attach = require("lsp").common_on_attach,
  filetypes = { "tf", "terraform", "hcl" },
}

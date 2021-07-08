if require("lv-utils").check_lsp_client_active "terraformls" then
  return
end

require("lspconfig").terraformls.setup {
  cmd = { DATA_PATH .. "/lspinstall/terraform/terraform-ls", "serve" },
  on_attach = require("lsp").common_on_attach,
  filetypes = { "tf", "terraform", "hcl" },
}

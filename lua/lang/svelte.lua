M.lsp = function()
  if require("lv-utils").check_lsp_client_active "svelte" then
    return
  end

  require("lspconfig").svelte.setup {
    cmd = { O.lang.svelte.lsp.path, "--stdio" },
    filetypes = { "svelte" },
    root_dir = require("lspconfig.util").root_pattern("package.json", ".git"),
    on_attach = require("lsp").common_on_attach,
  }
end

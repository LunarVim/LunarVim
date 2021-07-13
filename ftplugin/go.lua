O.formatters.filetype["go"] = {
  function()
    return {
      exe = O.lang.go.formatter.exe,
      args = O.lang.go.formatter.args,
      stdin = not (O.lang.go.formatter.stdin ~= nil),
    }
  end,
}

require("formatter.config").set_defaults {
  logging = false,
  filetype = O.formatters.filetype,
}

if not require("lv-utils").check_lsp_client_active "gopls" then
  require("lspconfig").gopls.setup {
    cmd = { DATA_PATH .. "/lspinstall/go/gopls" },
    settings = { gopls = { analyses = { unusedparams = true }, staticcheck = true } },
    root_dir = require("lspconfig").util.root_pattern(".git", "go.mod"),
    init_options = { usePlaceholders = true, completeUnimported = true },
    on_attach = require("lsp").common_on_attach,
  }
end

vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = false

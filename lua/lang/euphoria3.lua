M.lsp = function()
  if require("lv-utils").check_lsp_client_active "elixirls" then
    return
  end

  -- TODO: Remove this at some point
  require("lspconfig").elixirls.setup {
    cmd = { DATA_PATH .. "/lspinstall/elixir/elixir-ls/language_server.sh" },
    on_attach = require("lsp").common_on_attach,
  }
end

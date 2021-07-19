local M = {}

M.config = function()
  O.lang.graphql = {
    lsp = {
      path = "graphql-lsp",
    },
  }
end

M.format = function()
  -- TODO: implement formatter for language
  return "No formatter available!"
end

M.lint = function()
  -- TODO: implement linters (if applicable)
  return "No linters configured!"
end

M.lsp = function()
  if require("utils").check_lsp_client_active "graphql" then
    return
  end

  -- npm install -g graphql-language-service-cli
  require("lspconfig").graphql.setup {
    cmd = { O.lang.graphql.lsp.path, "server", "-m", "stream" },
    on_attach = require("lsp").common_on_attach,
  }
end

M.dap = function()
  -- TODO: implement dap
  return "No DAP configured!"
end

return M

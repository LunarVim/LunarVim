local M = {}

M.config = function()
  O.lang.html = {}
end

M.format = function()
  -- TODO: implement formatters (if applicable)
  return "No formatters configured!"
end

M.lint = function()
  -- TODO: implement linters (if applicable)
  return "No linters configured!"
end

M.lsp = function()
  if not require("lv-utils").check_lsp_client_active "html" then
    -- npm install -g vscode-html-languageserver-bin
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    require("lspconfig").html.setup {
      cmd = {
        "node",
        DATA_PATH .. "/lspinstall/html/vscode-html/html-language-features/server/dist/node/htmlServerMain.js",
        "--stdio",
      },
      on_attach = require("lsp").common_on_attach,
      capabilities = capabilities,
    }
  end
end

M.dap = function()
  -- TODO: implement dap
  return "No DAP configured!"
end

return M

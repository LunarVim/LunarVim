local M = {}

M.config = function()
  O.lang.html = {
    linters = {
      "tidy",
      -- https://docs.errata.ai/vale/scoping#html
      "vale",
    },
    lsp = {
      path = DATA_PATH .. "/lspinstall/html/vscode-html/html-language-features/server/dist/node/htmlServerMain.js",
    },
  }
end

M.format = function()
  -- TODO: implement formatters (if applicable)
  return "No formatters configured!"
end

M.lint = function()
  require("lint").linters_by_ft = {
    html = O.lang.html.linters,
  }
end

M.lsp = function()
  if not require("utils").check_lsp_client_active "html" then
    -- npm install -g vscode-html-languageserver-bin
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    require("lspconfig").html.setup {
      cmd = {
        "node",
        O.lang.html.lsp.path,
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

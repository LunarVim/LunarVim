local M = {}

local function find_local_prettier()
  vim.cmd "let proj = FindRootDirectory()"
  local root_dir = vim.api.nvim_get_var "proj"

  -- use the global prettier if you didn't find the local one
  local prettier_instance = root_dir .. "/node_modules/.bin/prettier"
  if vim.fn.executable(prettier_instance) ~= 1 then
    prettier_instance = O.lang.tsserver.formatter.exe
  end
  return prettier_instance
end

M.config = function()
  O.lang.css = {
    virtual_text = true,
    formatters = {
      {
        exe = find_local_prettier,
        args = function()
          return { "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) }
        end,
      },
    },
    lsp = {
      path = DATA_PATH .. "/lspinstall/css/vscode-css/css-language-features/server/dist/node/cssServerMain.js",
    },
  }
end

M.format = function()
  local ft = vim.bo.filetype
  O.formatters.filetype[ft] = require("lv-utils").wrap_formatters(O.lang.css.formatters)

  require("formatter.config").set_defaults {
    logging = false,
    filetype = O.formatters.filetype,
  }
end

M.lint = function()
  -- TODO: implement linters (if applicable)
  return "No linters configured!"
end

M.lsp = function()
  if not require("lv-utils").check_lsp_client_active "cssls" then
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    -- npm install -g vscode-css-languageserver-bin
    require("lspconfig").cssls.setup {
      cmd = {
        "node",
        O.lang.css.lsp.path,
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

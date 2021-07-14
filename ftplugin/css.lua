vim.cmd "let proj = FindRootDirectory()"
local root_dir = vim.api.nvim_get_var "proj"

-- use the global prettier if you didn't find the local one
local prettier_instance = root_dir .. "/node_modules/.bin/prettier"
if vim.fn.executable(prettier_instance) ~= 1 then
  prettier_instance = O.lang.tsserver.formatter.exe
end

local ft = vim.bo.filetype

local shared_config = {
  function()
    local args = { "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) }
    -- TODO: Use O.lang.[ft].formatter.args to allow user config for scss etc.
    local extended_args = require('lv-utils').extend_table(args, O.lang.css.formatter.args)
    return {
      exe = prettier_instance,
      args = extended_args,
      stdin = true,
    }
  end,
}

O.formatters.filetype[ft] = shared_config

require("formatter.config").set_defaults {
  logging = false,
  filetype = O.formatters.filetype,
}

if not require("lv-utils").check_lsp_client_active "cssls" then
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  -- npm install -g vscode-css-languageserver-bin
  require("lspconfig").cssls.setup {
    cmd = {
      "node",
      DATA_PATH .. "/lspinstall/css/vscode-css/css-language-features/server/dist/node/cssServerMain.js",
      "--stdio",
    },
    on_attach = require("lsp").common_on_attach,
    capabilities = capabilities,
  }
end

vim.cmd "setl ts=2 sw=2"

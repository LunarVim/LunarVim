local M = {}

M.config = function()
  O.lang.vim = {}
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
  if require("lv-utils").check_lsp_client_active "vimls" then
    return
  end

  -- npm install -g vim-language-server
  require("lspconfig").vimls.setup {
    cmd = { require("lsp.installer").get_langserver_path "vim", "--stdio" },
    on_attach = require("lsp").common_on_attach,
  }
end

M.dap = function()
  -- TODO: implement dap
  return "No DAP configured!"
end

return M

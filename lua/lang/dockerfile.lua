local M = {}

M.config = function()
  -- TODO: implement config for language
  return "No config available!"
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
  if require("lv-utils").check_lsp_client_active "dockerls" then
    return
  end

  -- npm install -g dockerfile-language-server-nodejs
  require("lspconfig").dockerls.setup {
    cmd = { DATA_PATH .. "/lspinstall/dockerfile/node_modules/.bin/docker-langserver", "--stdio" },
    on_attach = require("lsp").common_on_attach,
    root_dir = vim.loop.cwd,
  }
end

M.dap = function()
  -- TODO: implement dap
  return "No DAP configured!"
end

return M

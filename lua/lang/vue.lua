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
  if require("lv-utils").check_lsp_client_active "vuels" then
    return
  end

  -- Vue language server configuration (vetur)
  require("lspconfig").vuels.setup {
    cmd = { DATA_PATH .. "/lspinstall/vue/node_modules/.bin/vls", "--stdio" },
    on_attach = require("lsp").common_on_attach,
    root_dir = require("lspconfig").util.root_pattern(".git", "vue.config.js", "package.json", "yarn.lock"),
  }
end

M.dap = function()
  -- TODO: implement dap
  return "No DAP configured!"
end

return M

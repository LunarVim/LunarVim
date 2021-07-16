local M = {}

M.config = function()
  O.lang.erlang = {}
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
  if require("lv-utils").check_lsp_client_active "clojure_lsp" then
    return
  end

  require("lspconfig").clojure_lsp.setup {
    cmd = { DATA_PATH .. "/lspinstall/clojure/clojure-lsp" },
    on_attach = require("lsp").common_on_attach,
  }
end

M.dap = function()
  -- TODO: implement dap
  return "No DAP configured!"
end

return M

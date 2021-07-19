local M = {}

M.config = function()
  local elm_bin = DATA_PATH .. "/lspinstall/elm/node_modules/.bin"

  O.lang.elm = {
    lsp = {
      path = elm_bin .. "/elm-language-server",
      format = elm_bin .. "/elm-format",
      root = elm_bin,
      test = elm_bin .. "/elm-test",
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
  if require("utils").check_lsp_client_active "elmls" then
    return
  end

  require("lspconfig").elmls.setup {
    cmd = { O.lang.elm.lsp.path },
    on_attach = require("lsp").common_on_attach,
    init_options = {
      elmAnalyseTrigger = "change",
      elmFormatPath = O.lang.elm.lsp.format,
      elmPath = O.lang.elm.lsp.root,
      elmTestPath = O.lang.elm.lsp.test,
    },
  }
end

M.dap = function()
  -- TODO: implement dap
  return "No DAP configured!"
end

return M

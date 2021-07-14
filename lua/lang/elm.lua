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
  if require("lv-utils").check_lsp_client_active "elmls" then
    return
  end

  require("lspconfig").elmls.setup {
    cmd = { DATA_PATH .. "/lspinstall/elm/node_modules/.bin/elm-language-server" },
    init_options = {
      elmAnalyseTrigger = "change",
      elmFormatPath = DATA_PATH .. "/lspinstall/elm/node_modules/.bin/elm-format",
      elmPath = DATA_PATH .. "/lspinstall/elm/node_modules/.bin/elm",
      elmTestPath = DATA_PATH .. "/lspinstall/elm/node_modules/.bin/elm-test",
    },
  }
end

M.dap = function()
  -- TODO: implement dap
  return "No DAP configured!"
end

return M

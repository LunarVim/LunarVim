require("lspconfig").elmls.setup {
  cmd = { DATA_PATH .. "/lspinstall/elm/node_modules/.bin/elm-language-server" },
  init_options = {
    elmAnalyseTrigger = "change",
    elmFormatPath = DATA_PATH .. "/lspinstall/elm/node_modules/.bin/elm-format",
    elmPath = DATA_PATH .. "/lspinstall/elm/node_modules/.bin/elm",
    elmTestPath = DATA_PATH .. "/lspinstall/elm/node_modules/.bin/elm-test",
  },
}

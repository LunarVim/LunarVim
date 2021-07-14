local M = {}

M.config = function()
  -- TODO: implement config for language
  return "No config available!"
end

M.format = function()
  O.formatters.filetype["json"] = {
    function()
      return {
        exe = O.lang.json.formatter.exe,
        args = O.lang.json.formatter.args,
        stdin = not (O.lang.json.formatter.stdin ~= nil),
      }
    end,
  }

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
  if require("lv-utils").check_lsp_client_active "jsonls" then
    return
  end

  -- npm install -g vscode-json-languageserver
  require("lspconfig").jsonls.setup {
    cmd = {
      "node",
      DATA_PATH .. "/lspinstall/json/vscode-json/json-language-features/server/dist/node/jsonServerMain.js",
      "--stdio",
    },
    on_attach = require("lsp").common_on_attach,

    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
        end,
      },
    },
  }
end

M.dap = function()
  -- TODO: implement dap
  return "No DAP configured!"
end

return M

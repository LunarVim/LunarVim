local M = {}

M.config = function()
  O.lang.json = {
    diagnostics = {
      virtual_text = { spacing = 0, prefix = "" },
      signs = true,
      underline = true,
    },
    formatter = {
      exe = "python",
      args = { "-m", "json.tool" },
      stdin = true,
    },
    lsp = {
      path = DATA_PATH .. "/lspinstall/json/vscode-json/json-language-features/server/dist/node/jsonServerMain.js",
    },
  }
end

M.format = function()
  O.formatters.filetype["json"] = {
    function()
      return {
        exe = O.lang.json.formatter.exe,
        args = O.lang.json.formatter.args,
        stdin = O.lang.json.formatter.stdin,
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
  if require("utils").check_lsp_client_active "jsonls" then
    return
  end

  -- npm install -g vscode-json-languageserver
  require("lspconfig").jsonls.setup {
    cmd = {
      "node",
      O.lang.json.lsp.path,
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

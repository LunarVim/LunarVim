local M = {}

M.config = function()
  O.formatters.filetype["yaml"] = {
    function()
      return {
        exe = O.lang.yaml.formatter.exe,
        args = O.lang.yaml.formatter.args,
        stdin = not (O.lang.yaml.formatter.stdin ~= nil),
      }
    end,
  }
  require("formatter.config").set_defaults {
    logging = false,
    filetype = O.formatters.filetype,
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
  if require("lv-utils").check_lsp_client_active "yamlls" then
    return
  end

  -- npm install -g yaml-language-server
  require("lspconfig").yamlls.setup {
    cmd = { DATA_PATH .. "/lspinstall/yaml/node_modules/.bin/yaml-language-server", "--stdio" },
    on_attach = require("lsp").common_on_attach,
  }
end

M.dap = function()
  -- TODO: implement dap
  return "No DAP configured!"
end

return M

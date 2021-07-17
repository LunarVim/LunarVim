local M = {}

M.config = function()
  O.lang.yaml = {
    formatter = {
      exe = "prettier",
      args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote" },
      stdin = true,
    },
  }
end

M.format = function()
  O.formatters.filetype["yaml"] = {
    function()
      return {
        exe = O.lang.yaml.formatter.exe,
        args = O.lang.yaml.formatter.args,
        stdin = O.lang.yaml.formatter.stdin,
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

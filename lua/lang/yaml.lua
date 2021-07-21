local M = {}

local formatter_profiles = {
  prettier = {
    exe = "prettier",
    args = function()
      return { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote" }
    end,
    stdin = true,
  },
}

M.config = function()
  O.lang.yaml = {
    formatters = {
      "prettier",
    },
    lsp = {
      path = DATA_PATH .. "/lspinstall/yaml/node_modules/.bin/yaml-language-server",
    },
  }
end

M.format = function()
  O.formatters.filetype["yaml"] = require("lv-utils").wrap_formatters(O.lang.yaml.formatters, formatter_profiles)

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
    cmd = { O.lang.yaml.lsp.path, "--stdio" },
    on_attach = require("lsp").common_on_attach,
  }
end

M.dap = function()
  -- TODO: implement dap
  return "No DAP configured!"
end

return M

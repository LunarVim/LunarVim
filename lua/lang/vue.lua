local M = {}

M.config = function()
  O.lang.vue = {
    formatter = {
      exe = "prettier",
      args = {
        "--stdin-filepath",
        "${FILEPATH}",
      },
      stdin = true,
    },
    auto_import = true,
    lsp = {
      path = DATA_PATH .. "/lspinstall/vue/node_modules/.bin/vls",
    },
  }
end

M.format = function()
  vim.cmd "let proj = FindRootDirectory()"
  local root_dir = vim.api.nvim_get_var "proj"

  -- use the global formatter if you didn't find the local one
  local formatter_instance = root_dir .. "/node_modules/.bin/" .. O.lang.vue.formatter.exe
  if vim.fn.executable(formatter_instance) ~= 1 then
    formatter_instance = O.lang.vue.formatter.exe
  end

  local ft = vim.bo.filetype
  O.formatters.filetype[ft] = {
    function()
      local utils = require "utils"
      return {
        exe = formatter_instance,
        args = utils.gsub_args(O.lang.vue.formatter.args),
        stdin = O.lang.vue.formatter.stdin,
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
  if require("utils").check_lsp_client_active "vuels" then
    return
  end

  -- Vue language server configuration (vetur)
  require("lspconfig").vuels.setup {
    cmd = { O.lang.vue.lsp.path, "--stdio" },
    on_attach = require("lsp").common_on_attach,
  }

  require("lsp.ts-fmt-lint").setup()
end

M.dap = function()
  -- TODO: implement dap
  return "No DAP configured!"
end

return M

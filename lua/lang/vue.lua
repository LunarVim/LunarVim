local M = {}

local function find_local_prettier()
  vim.cmd "let proj = FindRootDirectory()"
  local root_dir = vim.api.nvim_get_var "proj"

  -- use the global formatter if you didn't find the local one
  local formatter_instance = root_dir .. "/node_modules/.bin/" .. O.lang.vue.formatter.exe
  if vim.fn.executable(formatter_instance) ~= 1 then
    formatter_instance = O.lang.vue.formatter.exe
  end
  return formatter_instance
end

M.config = function()
  O.lang.vue = {
    formatters = {
      {
        exe = "prettier",
        args = function()
          return require("lv-utils").gsub_args {
            "--stdin-filepath",
            "${FILEPATH}",
          }
        end,
        stdin = true,
      },
    },
    auto_import = true,
    lsp = {
      path = DATA_PATH .. "/lspinstall/vue/node_modules/.bin/vls",
    },
  }
end

M.format = function()
  local ft = vim.bo.filetype
  O.formatters.filetype[ft] = require("lv-utils").wrap_formatters(O.lang.vue.formatters)

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
  if require("lv-utils").check_lsp_client_active "vuels" then
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

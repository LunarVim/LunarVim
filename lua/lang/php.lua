local M = {}

local formatter_profiles = {
  phcbf = {
    exe = "phpcbf",
    args = function()
      return { "--standard=PSR12", vim.api.nvim_buf_get_name(0) }
    end,
    stdin = false,
    tempfile_prefix = ".formatter",
  },
}

M.config = function()
  O.lang.php = {
    format = {
      format = {
        default = "psr12",
      },
    },
    environment = {
      php_version = "7.4",
    },
    diagnostics = {
      virtual_text = { spacing = 0, prefix = "" },
      signs = true,
      underline = true,
    },
    filetypes = { "php", "phtml" },
    formatters = {
      "phcbf",
    },
    lsp = {
      path = DATA_PATH .. "/lspinstall/php/node_modules/.bin/intelephense",
    },
  }
end

M.format = function()
  O.formatters.filetype["php"] = require("lv-utils").wrap_formatters(O.lang.php.formatters, formatter_profiles)

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
  if require("lv-utils").check_lsp_client_active "intelephense" then
    return
  end

  require("lspconfig").intelephense.setup {
    cmd = { O.lang.php.lsp.path, "--stdio" },
    on_attach = require("lsp").common_on_attach,
    handlers = {
      ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = O.lang.php.diagnostics.virtual_text,
        signs = O.lang.php.diagnostics.signs,
        underline = O.lang.php.diagnostics.underline,
        update_in_insert = true,
      }),
    },
    filetypes = O.lang.php.filetypes,
    settings = {
      intelephense = {
        format = {
          braces = O.lang.php.format.braces,
        },
        environment = {
          phpVersion = O.lang.php.environment.php_version,
        },
      },
    },
  }
end

M.dap = function()
  -- TODO: implement dap
  return "No DAP configured!"
end

return M

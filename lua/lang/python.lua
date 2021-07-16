local M = {}

M.config = function()
  O.lang.python = {
    -- @usage can be flake8 or yapf
    linter = "",
    isort = false,
    diagnostics = {
      virtual_text = { spacing = 0, prefix = "" },
      signs = true,
      underline = true,
    },
    analysis = {
      type_checking = "basic",
      auto_search_paths = true,
      use_library_code_types = true,
    },
    formatter = {
      exe = "yapf",
      args = {},
      stdin = true,
    },
  }
end

M.format = function()
  O.formatters.filetype["python"] = {
    function()
      return {
        exe = O.lang.python.formatter.exe,
        args = O.lang.python.formatter.args,
        stdin = O.lang.python.formatter.stdin,
      }
    end,
  }

  require("formatter.config").set_defaults {
    logging = false,
    filetype = O.formatters.filetype,
  }
end

M.lint = function()
  if require("lv-utils").check_lsp_client_active "efm" then
    return
  end
  local python_arguments = {}

  local flake8 = {
    LintCommand = "flake8 --ignore=E501 --stdin-display-name ${INPUT} -",
    lintStdin = true,
    lintFormats = { "%f:%l:%c: %m" },
  }

  local isort = { formatCommand = "isort --quiet -", formatStdin = true }

  if O.lang.python.linter == "flake8" then
    table.insert(python_arguments, flake8)
  end

  if O.lang.python.isort then
    table.insert(python_arguments, isort)
  end

  if not require("lv-utils").check_lsp_client_active "efm" then
    require("lspconfig").efm.setup {
      cmd = { DATA_PATH .. "/lspinstall/efm/efm-langserver" },
      init_options = { documentFormatting = true, codeAction = false },
      root_dir = require("lspconfig").util.root_pattern(".git/", "requirements.txt"),
      filetypes = { "python" },
      settings = {
        rootMarkers = { ".git/", "requirements.txt" },
        languages = {
          python = python_arguments,
        },
      },
    }
  end
end

M.lsp = function()
  if require("lv-utils").check_lsp_client_active "pyright" then
    return
  end
  -- npm i -g pyright
  require("lspconfig").pyright.setup {
    cmd = {
      DATA_PATH .. "/lspinstall/python/node_modules/.bin/pyright-langserver",
      "--stdio",
    },
    on_attach = require("lsp").common_on_attach,
    handlers = {
      ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = O.lang.python.diagnostics.virtual_text,
        signs = O.lang.python.diagnostics.signs,
        underline = O.lang.python.diagnostics.underline,
        update_in_insert = true,
      }),
    },
    settings = {
      python = {
        analysis = {
          typeCheckingMode = O.lang.python.analysis.type_checking,
          autoSearchPaths = O.lang.python.analysis.auto_search_paths,
          useLibraryCodeForTypes = O.lang.python.analysis.use_library_code_types,
        },
      },
    },
  }
end

M.dap = function()
  if O.plugin.dap.active then
    local dap_install = require "dap-install"
    dap_install.config("python_dbg", {})
  end
end

return M

local M = {}

M.config = function()
  O.lang.sh = {
    -- @usage can be 'shellcheck'
    linter = "",
    -- @usage can be 'shfmt'
    diagnostics = {
      virtual_text = { spacing = 0, prefix = "" },
      signs = true,
      underline = true,
    },
    formatter = {
      exe = "shfmt",
      args = { "-w" },
      stdin = false,
    },
  }
end

M.format = function()
  O.formatters.filetype["sh"] = {
    function()
      return {
        exe = O.lang.sh.formatter.exe,
        args = O.lang.sh.formatter.args,
        stdin = not (O.lang.sh.formatter.stdin ~= nil),
        tempfile_prefix = ".formatter",
      }
    end,
  }

  require("formatter.config").set_defaults {
    logging = false,
    filetype = O.formatters.filetype,
  }
end

M.lint = function()
  -- sh
  local sh_arguments = {}

  local shfmt = { formatCommand = "shfmt -ci -s -bn", formatStdin = true }

  local shellcheck = {
    LintCommand = "shellcheck -f gcc -x",
    lintFormats = { "%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m" },
  }

  if O.lang.sh.linter == "shellcheck" then
    table.insert(sh_arguments, shellcheck)
  end

  if not require("lv-utils").check_lsp_client_active "efm" then
    require("lspconfig").efm.setup {
      -- init_options = {initializationOptions},
      cmd = { DATA_PATH .. "/lspinstall/efm/efm-langserver" },
      on_attach = require("lsp").common_on_attach,
      init_options = { documentFormatting = true, codeAction = false },
      root_dir = require("lspconfig").util.root_pattern ".git/",
      filetypes = { "sh" },
      settings = {
        rootMarkers = { ".git/" },
        languages = {
          sh = sh_arguments,
        },
      },
    }
  end
end

M.lsp = function()
  if not require("lv-utils").check_lsp_client_active "bashls" then
    -- npm i -g bash-language-server
    require("lspconfig").bashls.setup {
      cmd = { DATA_PATH .. "/lspinstall/bash/node_modules/.bin/bash-language-server", "start" },
      on_attach = require("lsp").common_on_attach,
      filetypes = { "sh", "zsh" },
    }
  end
end

M.dap = function()
  -- TODO: implement dap
  return "No DAP configured!"
end

return M

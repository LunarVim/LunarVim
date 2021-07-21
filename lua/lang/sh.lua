local M = {}

local formatter_profiles = {
  shfmt = {
    exe = "shfmt",
    args = { "-w" },
    stdin = false,
    tempfile_prefix = ".formatter",
  },
}

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
    formatters = {
      "shfmt",
    },
    linters = { "shellcheck" },
    lsp = {
      path = DATA_PATH .. "/lspinstall/bash/node_modules/.bin/bash-language-server",
    },
  }
end

M.format = function()
  O.formatters.filetype["sh"] = require("lv-utils").wrap_formatters(O.lang.sh.formatters, formatter_profiles)

  require("formatter.config").set_defaults {
    logging = false,
    filetype = O.formatters.filetype,
  }
end

M.lint = function()
  require("lint").linters_by_ft = {
    sh = O.lang.sh.linters,
  }
end

M.lsp = function()
  if not require("lv-utils").check_lsp_client_active "bashls" then
    -- npm i -g bash-language-server
    require("lspconfig").bashls.setup {
      cmd = { O.lang.sh.lsp.path, "start" },
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

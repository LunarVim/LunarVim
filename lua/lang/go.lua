local M = {}

local formatter_profiles = {
  gofmt = {
    exe = "gofmt",
    args = {},
    stdin = true,
  },
}

M.config = function()
  O.lang.go = {
    formatters = {
      "gofmt",
    },
    linters = {
      "golangcilint",
      "revive",
    },
    lsp = {
      path = DATA_PATH .. "/lspinstall/go/gopls",
    },
  }
end

M.format = function()
  O.formatters.filetype["go"] = require("lv-utils").wrap_formatters(O.lang.go.formatters, formatter_profiles)

  require("formatter.config").set_defaults {
    logging = false,
    filetype = O.formatters.filetype,
  }
end

M.lint = function()
  require("lint").linters_by_ft = {
    go = O.lang.go.linters,
  }
end

M.lsp = function()
  if not require("lv-utils").check_lsp_client_active "gopls" then
    require("lspconfig").gopls.setup {
      cmd = { O.lang.go.lsp.path },
      settings = { gopls = { analyses = { unusedparams = true }, staticcheck = true } },
      root_dir = require("lspconfig").util.root_pattern(".git", "go.mod"),
      init_options = { usePlaceholders = true, completeUnimported = true },
      on_attach = require("lsp").common_on_attach,
    }
  end
end

M.dap = function()
  -- TODO: implement dap
  return "No DAP configured!"
end

return M

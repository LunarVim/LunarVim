local M = {}

M.config = function()
  O.lang.terraform = {
    formatters = {
      {
        exe = "terraform",
        args = { "fmt" },
        stdin = false,
        tempfile_prefix = ".formatter",
      },
    },
    lsp = {
      path = DATA_PATH .. "/lspinstall/terraform/terraform-ls",
    },
  }
end

M.format = function()
  O.formatters.filetype["hcl"] = require("lv-utils").wrap_formatters(O.lang.terraform.formatters)
  O.formatters.filetype["tf"] = O.formatters.filetype["hcl"]

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
  if require("lv-utils").check_lsp_client_active "terraformls" then
    return
  end

  require("lspconfig").terraformls.setup {
    cmd = { O.lang.terraform.lsp.path, "serve" },
    on_attach = require("lsp").common_on_attach,
    filetypes = { "tf", "terraform", "hcl" },
  }
end

M.dap = function()
  -- TODO: implement dap
  return "No DAP configured!"
end

return M

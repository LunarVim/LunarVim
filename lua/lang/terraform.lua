local M = {}

M.config = function()
  O.lang.terraform = {
    formatter = {
      exe = "terraform",
      args = { "fmt" },
      stdin = false,
    },
  }
end

M.format = function()
  O.formatters.filetype["hcl"] = {
    function()
      return {
        exe = O.lang.terraform.formatter.exe,
        args = O.lang.terraform.formatter.args,
        stdin = not (O.lang.terraform.formatter.stdin ~= nil),
        tempfile_prefix = ".formatter",
      }
    end,
  }
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
    cmd = { DATA_PATH .. "/lspinstall/terraform/terraform-ls", "serve" },
    on_attach = require("lsp").common_on_attach,
    filetypes = { "tf", "terraform", "hcl" },
  }
end

M.dap = function()
  -- TODO: implement dap
  return "No DAP configured!"
end

return M

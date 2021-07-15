local M = {}

M.config = function()
  O.lang.ruby = {
    diagnostics = {
      virtualtext = { spacing = 0, prefix = "" },
      signs = true,
      underline = true,
    },
    filetypes = { "rb", "erb", "rakefile", "ruby" },
    formatter = {
      exe = "rufo",
      args = { "-x" },
    },
  }
end

M.format = function()
  O.formatters.filetype["ruby"] = {
    function()
      return {
        exe = O.lang.ruby.formatter.exe,
        args = O.lang.ruby.formatter.args,
        stdin = not (O.lang.ruby.formatter.stdin ~= nil),
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
  if require("lv-utils").check_lsp_client_active "solargraph" then
    return
  end

  -- If you are using rvm, make sure to change below configuration
  require("lspconfig").solargraph.setup {
    cmd = { DATA_PATH .. "/lspinstall/ruby/solargraph/solargraph", "stdio" },
    on_attach = require("lsp").common_on_attach,
    handlers = {
      ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = O.lang.ruby.diagnostics.virtual_text,
        signs = O.lang.ruby.diagnostics.signs,
        underline = O.lang.ruby.diagnostics.underline,
        update_in_insert = true,
      }),
    },
    filetypes = O.lang.ruby.filetypes,
  }
end

M.dap = function()
  -- gem install readapt ruby-debug-ide
  if O.plugin.dap.active then
    local dap_install = require "dap-install"
    dap_install.config("ruby_vsc_dbg", {})
  end
end

return M

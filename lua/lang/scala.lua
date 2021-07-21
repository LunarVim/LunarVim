local M = {}

M.config = function()
  O.lang.scala = {
    metals = {
      active = false,
      server_version = "0.10.5",
      excluded_packages = {},
      show_implicit_arguments = false,
      show_inferred_type = true,
      status_bar_provider = false,
    },
    formatters = {
      {
        exe = "scalafmt",
        args = { "--stdin" },
        stdin = true,
      },
    },
  }
end

M.format = function()
  O.formatters.filetype["scala"] = require("lv-utils").wrap_formatters(O.lang.scala.formatters)
  O.formatters.filetype["sbt"] = O.formatters.filetype["scala"]
  --  To understand sbt files on stdin, scalafmt needs to assume any old filename
  --  that ends in .sbt.  Using a dummy filename instead of the actual one is
  --  required to support buffers of sbt filetype without the extension.
  O.formatters.filetype["sbt"].args = { "--stdin", "--assume-filename", "foo.sbt" }

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
  -- enable metal server integration
  if O.lang.scala.metals.active then
    vim.g["metals_server_version"] = O.lang.scala.metals.server_version
    -- https://github.com/scalameta/nvim-metals#prerequisites
    vim.opt_global.shortmess:remove("F"):append "c"
    local metals_config = require("metals").bare_config
    metals_config.on_attach = function()
      require("completion").on_attach()
    end
    metals_config.handlers["textDocument/publishDiagnostics"] =
      vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = {
          prefix = "",
        },
      })
    metals_config.settings = {
      showImplicitArguments = O.lang.scala.metals.show_implicit_arguments,
      showInferredType = O.lang.scala.metals.show_inferred_type,
      excludedPackages = O.lang.scala.metals.excluded_packages,
    }
    metals_config.init_options.statusBarProvider = O.lang.scala.metals.status_bar_provider
    require "lsp"
    require("metals").initialize_or_attach(metals_config)
  end
end

M.dap = function()
  -- TODO: implement dap
  return "No DAP configured!"
end

return M

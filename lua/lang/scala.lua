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
    formatter = {
      exe = "scalafmt",
      args = { "--stdin" },
      stdin = true,
    },
  }
end

M.format = function()
  O.formatters.filetype["scala"] = {
    function()
      return {
        exe = O.lang.scala.formatter.exe,
        args = O.lang.scala.formatter.args,
        stdin = O.lang.scala.formatter.stdin,
      }
    end,
  }
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
  local function scala_on_attach(client, bufnr)
    -- enable metal server integration
    if O.lang.scala.metals.active then
      vim.g["metals_server_version"] = O.lang.scala.metals.server_version

      local metals_config = require("metals").bare_config
      metals_config.settings = {
        showImplicitArguments = O.lang.scala.metals.show_implicit_arguments,
        showInferredType = O.lang.scala.metals.show_inferred_type,
        excludedPackages = O.lang.scala.metals.excluded_packages,
      }
      metals_config.init_options.statusBarProvider = O.lang.scala.metals.status_bar_provider
      require("metals").initialize_or_attach(metals_config)
    end
  end

  require("lspconfig").metals.setup {
    on_attach = scala_on_attach,
    filetypes = { "scala", "sbt" },
  }
end

M.dap = function()
  -- TODO: implement dap
  return "No DAP configured!"
end

return M

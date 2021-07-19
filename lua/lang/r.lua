local M = {}

M.config = function()
  -- R -e 'install.packages("formatR",repos = "http://cran.us.r-project.org")'
  -- R -e 'install.packages("readr",repos = "http://cran.us.r-project.org")'
  O.lang.r = {
    formatter = {
      exe = "R",
      args = {
        "--slave",
        "--no-restore",
        "--no-save",
        '-e "formatR::tidy_source(text=readr::read_file(file(\\"stdin\\")), arrow=FALSE)"',
      },
      stdin = true,
    },
  }
end

M.format = function()
  O.formatters.filetype["r"] = {
    function()
      return {
        exe = O.lang.r.formatter.exe,
        args = O.lang.r.formatter.args,
        stdin = O.lang.r.formatter.stdin,
      }
    end,
  }
  O.formatters.filetype["rmd"] = O.formatters.filetype["r"]

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
  if require("utils").check_lsp_client_active "r_language_server" then
    return
  end
  -- R -e 'install.packages("languageserver",repos = "http://cran.us.r-project.org")'
  require("lspconfig").r_language_server.setup {}
end

M.dap = function()
  -- TODO: implement dap
  return "No DAP configured!"
end

return M

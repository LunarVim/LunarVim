local M = {}

local formatter_profiles = {
  R = {
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

M.config = function()
  -- R -e 'install.packages("formatR",repos = "http://cran.us.r-project.org")'
  -- R -e 'install.packages("readr",repos = "http://cran.us.r-project.org")'
  O.lang.r = {
    formatters = {
      "R",
    },
  }
end

M.format = function()
  O.formatters.filetype["r"] = require("lv-utils").wrap_formatters(O.lang.r.formatters, formatter_profiles)
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
  if require("lv-utils").check_lsp_client_active "r_language_server" then
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

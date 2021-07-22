O.formatters.filetype["rmd"] = O.formatters.filetype["r"]
require("core.formatter").setup "r"
-- R -e 'install.packages("languageserver",repos = "http://cran.us.r-project.org")'
require("lsp").setup("r_language_server", {
  { "R", "--slave", "-e", "languageserver::run()" },
})

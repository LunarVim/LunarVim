require("core.formatter").setup "terraform"
O.formatters.filetype["tf"] = O.formatters.filetype["terraform"]
O.formatters.filetype["hcl"] = O.formatters.filetype["terraform"]

require("lsp").setup(O.lang.terraform.lsp.provider, O.lang.terraform.lsp.setup)

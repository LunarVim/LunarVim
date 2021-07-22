require("core.formatter").setup "terraform"
O.formatters.filetype["tf"] = O.formatters.filetype["terraform"]
O.formatters.filetype["hcl"] = O.formatters.filetype["terraform"]

require("lsp").setup("terraformls", { O.lang.terraform.lsp.path, "serve" })

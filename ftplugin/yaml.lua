require("core.formatter").setup "yaml"

require("lsp").setup(O.lang.yaml.lsp.provider, O.lang.yaml.lsp.setup)

-- TODO get from dap
-- require("lang.yaml").dap()

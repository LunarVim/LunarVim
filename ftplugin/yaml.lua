require("core.formatter").setup "yaml"

require("lsp").setup("yamlls", {
  O.lang.yaml.lsp.path,
  "--stdio",
})

-- TODO get from dap
-- require("lang.python").dap()

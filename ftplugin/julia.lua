local cmd = {
  "julia",
  "--startup-file=no",
  "--history-file=no",
  -- vim.fn.expand "~/.config/nvim/lua/lsp/julia/run.jl",
  CONFIG_PATH .. "/lua/lsp/julia/run.jl",
}
require("lspconfig").julials.setup {
  cmd = cmd,
  on_new_config = function(new_config, _)
    new_config.cmd = cmd
  end,
  filetypes = { "julia" },
}

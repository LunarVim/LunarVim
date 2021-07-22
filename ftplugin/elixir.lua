require("core.formatter").setup "elixir"

require("lsp").setup(O.lang.elixir.lsp.provider, O.lang.elixir.lsp.setup)

-- TODO: do we need this?
-- needed for the LSP to recognize elixir files (alternativly just use elixir-editors/vim-elixir)
-- vim.cmd [[
--   au BufRead,BufNewFile *.ex,*.exs set filetype=elixir
--   au BufRead,BufNewFile *.eex,*.leex,*.sface set filetype=eelixir
--   au BufRead,BufNewFile mix.lock set filetype=elixir
-- ]]

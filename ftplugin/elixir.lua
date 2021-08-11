require("lsp").setup "elixir"

-- TODO: do we need this?
-- needed for the LSP to recognize elixir files (alternatively just use elixir-editors/vim-elixir)
-- vim.cmd [[
--   au BufRead,BufNewFile *.ex,*.exs set filetype=elixir
--   au BufRead,BufNewFile *.eex,*.leex,*.sface set filetype=eelixir
--   au BufRead,BufNewFile mix.lock set filetype=elixir
-- ]]

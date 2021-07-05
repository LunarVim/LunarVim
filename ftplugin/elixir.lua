require("lspconfig").elixirls.setup {
  cmd = { DATA_PATH .. "/lspinstall/elixir/elixir-ls/language_server.sh" },
}

if O.lang.elixir.autoformat then
  require("lv-utils").define_augroups {
    _elixir_autoformat = {
      { "BufWritePre", "*.ex", "lua vim.lsp.buf.formatting_sync(nil, 1000)" },
    },
    _elixir_script_autoformat = {
      { "BufWritePre", "*.exs", "lua vim.lsp.buf.formatting_sync(nil, 1000)" },
    },
  }
end


-- needed for the LSP to recognize elixir files (alternativly just use elixir-editors/vim-elixir)
-- vim.cmd([[
--   au BufRead,BufNewFile *.ex,*.exs set filetype=elixir
--   au BufRead,BufNewFile *.eex,*.leex,*.sface set filetype=eelixir
--   au BufRead,BufNewFile mix.lock set filetype=elixir
-- ]])

if require("lv-utils").check_lsp_client_active "elixirls" then
  return
end

O.formatters.filetype["elixir"] = {
  function()
    return {
      exe = O.lang.elixir.formatter.exe,
      args = O.lang.elixir.formatter.args,
      stdin = not (O.lang.elixir.formatter.stdin ~= nil),
    }
  end,
}

require("formatter.config").set_defaults {
  logging = false,
  filetype = O.formatters.filetype,
}

require("lspconfig").elixirls.setup {
  cmd = { DATA_PATH .. "/lspinstall/elixir/elixir-ls/language_server.sh" },
}

-- needed for the LSP to recognize elixir files (alternativly just use elixir-editors/vim-elixir)
-- vim.cmd([[
--   au BufRead,BufNewFile *.ex,*.exs set filetype=elixir
--   au BufRead,BufNewFile *.eex,*.leex,*.sface set filetype=eelixir
--   au BufRead,BufNewFile mix.lock set filetype=elixir
-- ]])

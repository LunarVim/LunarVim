local M = {}

M.config = function()
  O.lang.elixir = {
    formatter = {
      exe = "mix",
      args = { "format" },
      stdin = true,
    },
  }
end

M.format = function()
  O.formatters.filetype["elixir"] = {
    function()
      return {
        exe = O.lang.elixir.formatter.exe,
        args = O.lang.elixir.formatter.args,
        stdin = O.lang.elixir.formatter.stdin,
      }
    end,
  }

  require("formatter.config").set_defaults {
    logging = false,
    filetype = O.formatters.filetype,
  }
end

M.lint = function()
  -- TODO: implement linters (if applicable)
  return "No linters configured!"
end

M.lsp = function()
  if require("lv-utils").check_lsp_client_active "elixirls" then
    return
  end

  require("lspconfig").elixirls.setup {
    cmd = { DATA_PATH .. "/lspinstall/elixir/elixir-ls/language_server.sh" },
    on_attach = require("lsp").common_on_attach,
  }
end

M.dap = function()
  -- TODO: implement dap
  return "No DAP configured!"
end

-- needed for the LSP to recognize elixir files (alternativly just use elixir-editors/vim-elixir)
-- vim.cmd [[
--   au BufRead,BufNewFile *.ex,*.exs set filetype=elixir
--   au BufRead,BufNewFile *.eex,*.leex,*.sface set filetype=eelixir
--   au BufRead,BufNewFile mix.lock set filetype=elixir
-- ]]

return M

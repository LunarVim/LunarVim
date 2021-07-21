local M = {}

local formatter_profiles = {
  mix = {
    exe = "mix",
    args = { "format" },
    stdin = true,
  },
}

M.config = function()
  O.lang.elixir = {
    formatters = {
      "mix",
    },
    lsp = {
      path = DATA_PATH .. "/lspinstall/elixir/elixir-ls/language_server.sh",
    },
  }
end

M.format = function()
  O.formatters.filetype["elixir"] = require("lv-utils").wrap_formatters(O.lang.elixir.formatters, formatter_profiles)

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
    cmd = { O.lang.elixir.lsp.path },
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

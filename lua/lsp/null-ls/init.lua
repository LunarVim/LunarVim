local M = {}

local null_ls = require "null-ls"

-- TODO: for linters and formatters with spaces and '-' replace with '_'
function M.setup(filetype)
  local null_formatters = require "lsp.null-ls.formatters"
  local null_linters = require "lsp.null-ls.linters"
  local formatters = null_formatters.list_configured(lvim.lang[filetype].formatters)
  local linters = null_linters.list_configured(lvim.lang[filetype].linters)

  for _, providers in ipairs { formatters, linters } do
    null_ls.register { sources = providers.supported }
  end
end

return M

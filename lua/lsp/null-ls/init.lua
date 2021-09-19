local M = {}

function M.list_supported_provider_names(filetype)
  local names = {}

  print "PASS"
  local formatters = require "lsp.null-ls.formatters"
  local linters = require "lsp.null-ls.linters"

  vim.list_extend(names, formatters.list_supported_names(filetype))
  vim.list_extend(names, linters.list_supported_names(filetype))

  return names
end

function M.list_unsupported_provider_names(filetype)
  local names = {}

  local formatters = require "lsp.null-ls.formatters"
  local linters = require "lsp.null-ls.linters"

  vim.list_extend(names, formatters.list_unsupported_names(filetype))
  vim.list_extend(names, linters.list_unsupported_names(filetype))

  return names
end

-- TODO: for linters and formatters with spaces and '-' replace with '_'
function M.register(providers, filetype, options)
  options = options or {}

  local ok, _ = pcall(require, "null-ls")
  if not ok then
    require("core.log"):error "Missing null-ls dependency"
    return
  end

  local formatters = require "lsp.null-ls.formatters"
  local linters = require "lsp.null-ls.linters"

  formatters.setup(providers.formatters, filetype, options)
  linters.setup(providers.linters, filetype, options)
end

function M.setup()
  local null_status_ok, null_ls = pcall(require, "null-ls")
  if null_status_ok then
    null_ls.config()
    require("lspconfig")["null-ls"].setup {}
  end

  local formatters = require "lsp.null-ls.formatters"
  local linters = require "lsp.null-ls.linters"

  for _, filetype in pairs(lvim.lang) do
    if filetype.formatters then
      formatters.setup(filetype.formatters, filetype)
    end
    if filetype.linters then
      linters.setup(filetype.linters, filetype)
    end
  end
end

return M

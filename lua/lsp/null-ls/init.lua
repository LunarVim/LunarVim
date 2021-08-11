local M = {}

local providers_by_ft = {}

local function list_provider_names(providers, registered)
  local names = {}

  local flag = registered == true and "supported" or "unsupported"
  for name, _ in pairs(providers[flag]) do
    table.insert(names, name)
  end

  return names
end

function M.list_provider_names(filetype, registered)
  local names = {}

  for _, providers in pairs(providers_by_ft[filetype]) do
    vim.list_extend(names, list_provider_names(providers, registered))
  end

  return names
end

function M.list_formatter_names(filetype, registered)
  return list_provider_names(providers_by_ft[filetype].formatters, registered)
end

function M.list_linter_names(filetype, registered)
  return list_provider_names(providers_by_ft[filetype].linters, registered)
end

-- TODO: for linters and formatters with spaces and '-' replace with '_'
function M.setup(filetype)
  local null_ls = require "null-ls"
  local null_formatters = require "lsp.null-ls.formatters"
  local null_linters = require "lsp.null-ls.linters"

  local formatters = null_formatters.list_configured(lvim.lang[filetype].formatters)
  local linters = null_linters.list_configured(lvim.lang[filetype].linters)

  local function register_providers(providers, provider_type)
    for _, flag in ipairs { "supported", "unsupported" } do
      for _, provider in ipairs(providers[flag]) do
        providers_by_ft[filetype][provider_type][flag][provider.name] = provider
      end
    end
    null_ls.register { sources = providers.supported }
  end

  providers_by_ft[filetype] = {
    formatters = {
      supported = {},
      unsupported = {},
    },
    linters = {
      supported = {},
      unsupported = {},
    },
  }

  register_providers(formatters, "formatters")
  register_providers(linters, "linters")
end

return M

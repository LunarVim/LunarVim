local M = {}

local providers_by_ft = {}

local function list_provider_names(providers, options)
  options = options or {}
  local names = {}

  local filter = options.filter or "supported"
  for name, _ in pairs(providers[filter]) do
    table.insert(names, name)
  end

  return names
end

function M.list_provider_names(filetype, options)
  local names = {}

  for _, providers in pairs(providers_by_ft[filetype]) do
    vim.list_extend(names, list_provider_names(providers, options))
  end

  return names
end

function M.list_supported_formatter_names(filetype)
  return list_provider_names(providers_by_ft[filetype].formatters, { filter = "supported" })
end

function M.list_supported_linter_names(filetype)
  return list_provider_names(providers_by_ft[filetype].linters, { filter = "supported" })
end

function M.list_unsupported_formatter_names(filetype)
  return list_provider_names(providers_by_ft[filetype].formatters, { filter = "unsupported" })
end

function M.list_unsupported_linter_names(filetype)
  return list_provider_names(providers_by_ft[filetype].linters, { filter = "unsupported" })
end

-- TODO: for linters and formatters with spaces and '-' replace with '_'
function M.setup(filetype, options)
  options = options or {}
  if providers_by_ft[filetype] and not options.force_reload then
    return
  end

  -- Reset the structure to allow reloading from updated configuration
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

  register_providers(formatters, "formatters")
  register_providers(linters, "linters")
end

return M

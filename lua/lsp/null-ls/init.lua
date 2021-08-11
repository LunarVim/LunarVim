local M = {}


-- TODO: for linters and formatters with spaces and '-' replace with '_'
function M.setup(filetype)
  local null_ls = require "null-ls"
  local null_formatters = require "lsp.null-ls.formatters"
  local null_linters = require "lsp.null-ls.linters"

  local formatters = null_formatters.list_configured(lvim.lang[filetype].formatters)
  local linters = null_linters.list_configured(lvim.lang[filetype].linters)

  local function register_providers(providers, provider_type)
    for _, flag in ipairs { "supported", "unsupported" } do
      require("core.log"):get_default().info("flag", flag, "providers", vim.inspect(providers[flag]))
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

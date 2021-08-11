local M = {}

local null_ls = require "null-ls"
local services = require "lsp.null-ls.services"
local logger = require("core.log"):get_default()

local function adapt_linter(linter)
  -- special case: fallback to "eslint"
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/9b8458bd1648e84169a7e8638091ba15c2f20fc0/doc/BUILTINS.md#eslint
  if linter.exe == "eslint_d" then
    return null_ls.builtins.diagnostics.eslint.with { command = "eslint_d" }
  end
  return null_ls.builtins.diagnostics[linter.exe]
end

function M.list_available(filetype)
  local linters = {}
  for _, provider in pairs(null_ls.builtins.diagnostics) do
    -- TODO: Add support for wildcard filetypes
    if vim.tbl_contains(provider.filetypes or {}, filetype) then
      table.insert(linters, provider.name)
    end
  end

  return linters
end

function M.list_configured(linter_configs)
  local linters, errors = {}, {}

  for _, lnt_config in pairs(linter_configs) do
    local linter = adapt_linter(lnt_config)
    if not linter then
      logger.error("Not a valid linter:", lnt_config.exe)
      errors[lnt_config.exe] = {} -- Add data here when necessary
    else
      local linter_cmd = services.find_command(linter._opts.command)
      if not linter_cmd then
        logger.warn("Not found:", linter._opts.command)
        errors[lnt_config.exe] = {} -- Add data here when necessary
      else
        logger.info("Using linter:", linter_cmd)
        linters[lnt_config.exe] = linter.with { command = linter_cmd }
      end
    end
  end

  return { supported = linters, unsupported = errors }
end

return M

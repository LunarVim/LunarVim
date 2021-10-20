local M = {}

local null_ls = require "null-ls"
local services = require "lvim.lsp.null-ls.services"
local Log = require "lvim.core.log"

function M.list_registered_providers(filetype)
  local null_ls_methods = require "null-ls.methods"
  local linter_method = null_ls_methods.internal["DIAGNOSTICS"]
  local registered_providers = services.list_registered_providers_names(filetype)
  return registered_providers[linter_method] or {}
end

function M.list_available(filetype)
  local linters = {}
  local tbl = require "lvim.utils.table"
  for _, provider in pairs(null_ls.builtins.diagnostics) do
    if tbl.contains(provider.filetypes or {}, function(ft)
      return ft == "*" or ft == filetype
    end) then
      table.insert(linters, provider.name)
    end
  end

  return linters
end

function M.list_configured(linter_configs)
  local linters, errors = {}, {}

  for _, lnt_config in pairs(linter_configs) do
    local linter_name = lnt_config.exe:gsub("-", "_")
    local linter = null_ls.builtins.diagnostics[linter_name]

    if not linter then
      Log:error("Not a valid linter: " .. lnt_config.exe)
      errors[lnt_config.exe] = {} -- Add data here when necessary
    else
      local linter_cmd = services.find_command(linter._opts.command)
      if not linter_cmd then
        Log:warn("Not found: " .. linter._opts.command)
        errors[lnt_config.exe] = {} -- Add data here when necessary
      else
        Log:debug("Using linter: " .. linter_cmd)
        linters[lnt_config.exe] = linter.with {
          command = linter_cmd,
          extra_args = lnt_config.args,
          filetypes = lnt_config.filetypes,
        }
      end
    end
  end

  return { supported = linters, unsupported = errors }
end

function M.setup(linter_configs)
  if vim.tbl_isempty(linter_configs) then
    return
  end

  local linters = M.list_configured(linter_configs)
  null_ls.register { sources = linters.supported }
end

return M

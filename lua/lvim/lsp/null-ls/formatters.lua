local M = {}

local Log = require "lvim.core.log"

local null_ls = require "null-ls"
local services = require "lvim.lsp.null-ls.services"
local method = null_ls.methods.FORMATTING

function M.list_registered(filetype)
  local registered_providers = services.list_registered_providers_names(filetype)
  return registered_providers[method] or {}
end

function M.list_supported(filetype)
  local s = require "null-ls.sources"
  local supported_formatters = s.get_supported(filetype, "formatting")
  table.sort(supported_formatters)
  return supported_formatters
end

function M.setup(formatter_configs)
  if vim.tbl_isempty(formatter_configs) then
    return
  end

  local registered = services.register_sources(formatter_configs, method)

  if #registered > 0 then
    Log:debug("Registered the following formatters: " .. unpack(registered))
  end
end

return M

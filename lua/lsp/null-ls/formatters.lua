local M = {}
local formatters_by_ft = {}

local null_ls = require "null-ls"
local services = require "lsp.null-ls.services"
local logger = require("core.log"):get_default()

local function list_names(formatters, options)
  options = options or {}
  local filter = options.filter or "supported"

  return vim.tbl_keys(formatters[filter])
end

function M.list_supported_names(filetype)
  if not formatters_by_ft[filetype] then
    return {}
  end
  return list_names(formatters_by_ft[filetype], { filter = "supported" })
end

function M.list_unsupported_names(filetype)
  if not formatters_by_ft[filetype] then
    return {}
  end
  return list_names(formatters_by_ft[filetype], { filter = "unsupported" })
end

function M.list_available(filetype)
  local formatters = {}
  for _, provider in pairs(null_ls.builtins.formatting) do
    -- TODO: Add support for wildcard filetypes
    if vim.tbl_contains(provider.filetypes or {}, filetype) then
      table.insert(formatters, provider.name)
    end
  end

  return formatters
end

function M.list_configured(formatter_configs)
  local formatters, errors = {}, {}

  for _, fmt_config in ipairs(formatter_configs) do
    local formatter = null_ls.builtins.formatting[fmt_config.exe]

    if not formatter then
      logger.error("Not a valid formatter:", fmt_config.exe)
      errors[fmt_config.exe] = {} -- Add data here when necessary
    else
      local formatter_cmd = services.find_command(formatter._opts.command)
      if not formatter_cmd then
        logger.warn("Not found:", formatter._opts.command)
        errors[fmt_config.exe] = {} -- Add data here when necessary
      else
        logger.info("Using formatter:", formatter_cmd)
        formatters[fmt_config.exe] = formatter.with { command = formatter_cmd, extra_args = fmt_config.args }
      end
    end
  end

  return { supported = formatters, unsupported = errors }
end

function M.setup(filetype, options)
  if (formatters_by_ft[filetype] and not options.force_reload) or not lvim.lang[filetype] then
    return
  end

  formatters_by_ft[filetype] = M.list_configured(lvim.lang[filetype].formatters)
  null_ls.register { sources = formatters_by_ft[filetype].supported }
end

return M

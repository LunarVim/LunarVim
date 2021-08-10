local M = {}

local null_ls = require "null-ls"
local services = require "lsp.null-ls.services"
local logger = require("core.log"):get_default()

function M.list_configured(formatter_configs)
  local formatters, errors = {}, {}

  for _, fmt_config in ipairs(formatter_configs) do
    local formatter = null_ls.builtins.formatting[fmt_config.exe]
    if not formatter then
      logger.error("Not a valid formatter:", fmt_config.exe)
    else
      local formatter_cmd = services.find_command(formatter._opts.command)
      if not formatter_cmd then
        logger.warn("Not found:", formatter._opts.command)
        table.insert(errors, fmt_config.exe)
      else
        logger.info("Using formatter:", formatter_cmd)
        table.insert(formatters, formatter.with { command = formatter_cmd })
      end
    end
  end

  return { supported = formatters, unsupported = errors }
end

return M

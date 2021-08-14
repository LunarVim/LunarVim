local M = {}

local function find_root_dir()
  local util = require "lspconfig/util"
  local lsp_utils = require "lsp.utils"

  local ts_client = lsp_utils.get_active_client_by_ft "typescript"
  if not ts_client then
    local dirname = vim.fn.expand "%:p:h"
    return util.root_pattern "package.json"(dirname)
  end
  return ts_client.config.root_dir
end

local function from_node_modules(command)
  local logger = require("core.log"):get_default()
  local root_dir = find_root_dir()

  if not root_dir then
    logger.error(string.format("Unable to find the [%s] node module.", command))
    return nil
  end

  return root_dir .. "/node_modules/.bin/" .. command
end

local local_providers = {
  prettier = { find = from_node_modules },
  prettierd = { find = from_node_modules },
  prettier_d_slim = { find = from_node_modules },
  eslint_d = { find = from_node_modules },
  eslint = { find = from_node_modules },
}

function M.find_command(command)
  if local_providers[command] then
    local local_command = local_providers[command].find(command)
    if local_command and vim.fn.executable(local_command) == 1 then
      return local_command
    end
  end

  if vim.fn.executable(command) == 1 then
    return command
  end
  return nil
end

return M

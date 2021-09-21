local M = {}

local function find_root_dir()
  local util = require "lspconfig/util"
  local lsp_utils = require "lsp.utils"

  local status_ok, ts_client = lsp_utils.is_client_active "typescript"
  if status_ok then
    return ts_client.config.root_dir
  end
  local dirname = vim.fn.expand "%:p:h"
  return util.root_pattern "package.json"(dirname)
end

local function from_node_modules(command)
  local root_dir = find_root_dir()

  if not root_dir then
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
  stylelint = { find = from_node_modules },
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

function M.list_registered_providers_names(filetype)
  local u = require "null-ls.utils"
  local c = require "null-ls.config"
  local registered = {}
  for method, source in pairs(c.get()._methods) do
    for name, filetypes in pairs(source) do
      if u.filetype_matches(filetypes, filetype) then
        registered[method] = registered[method] or {}
        table.insert(registered[method], name)
      end
    end
  end
  return registered
end

return M

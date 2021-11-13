local M = {}

local function find_root_dir()
  local util = require "lspconfig/util"
  local lsp_utils = require "lvim.lsp.utils"

  local ts_client = lsp_utils.is_client_active "typescript"
  if ts_client then
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
  -- local c = require "null-ls.config"
  local s = require "null-ls.sources"
  -- print(vim.inspect(s.get_all()))
  local method = nil

  local registered = {}
  for key, val in pairs(s.get_all()) do
    -- print("key", vim.inspect(key))
    -- print("val",vim.inspect(val))
      -- print("ft", filetype)
      -- print("fts", vim.inspect(filetypes.filetypes))
      -- print("name", name)
      -- print(vim.inspect(val.filetypes))
      -- print(val.filetypes[1])
      -- print("wtf", vim.inspect(val.methods["NULL_LS_FORMATTING"]))
      if val.methods["NULL_LS_FORMATTING"] then
        method = "NULL_LS_FORMATTING"
      end

      -- print("method", method)

    for name, filetypes in pairs(val.filetypes) do
      -- print("name", val.name)
      -- print("wtf", vim.inspect(filetypes))
      if filetype == name then
        registered[method] = registered[val.name] or {}
        table.insert(registered[method], val.name)
        -- print("hi")
      end
    end
  end
  -- print("registered", vim.inspect(registered))
  return registered
end

return M

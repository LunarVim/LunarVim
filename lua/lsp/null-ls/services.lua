local M = {}

local logger = require("core.log"):get_default()

local function find_root_dir()
  if lvim.builtin.rooter.active then
    --- use vim-rooter to set root_dir
    vim.cmd "let root_dir = FindRootDirectory()"
    return vim.api.nvim_get_var "root_dir"
  end

  -- TODO: Rework this to not make it javascript specific
  --- use LSP to set root_dir
  local lsp_utils = require "lsp.utils"
  local ts_client = lsp_utils.get_active_client_by_ft "typescript"
  if ts_client == nil then
    logger.error "Unable to determine root directory since tsserver didn't start correctly"
    return nil
  end

  return ts_client.config.root_dir
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

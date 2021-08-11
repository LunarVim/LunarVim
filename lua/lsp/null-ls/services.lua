local M = {}

local logger = require("core.log"):get_default()

local function find_local_node_package(root_dir, command)
  return root_dir .. "/node_modules/.bin/" .. command
end

local local_installations = {
  prettier = find_local_node_package,
  prettierd = find_local_node_package,
  prettier_d_slim = find_local_node_package,
  eslint_d = find_local_node_package,
  eslint = find_local_node_package,
}

local function find_root_dir()
  if lvim.builtin.rooter.active then
    --- use vim-rooter to set root_dir
    vim.cmd "let root_dir = FindRootDirectory()"
    return vim.api.nvim_get_var "root_dir"
  end

  -- TODO: Rework this to not make it javascript specific
  --- use LSP to set root_dir
  local ts_client = require("utils").get_active_client_by_ft "typescript"
  if ts_client == nil then
    logger.error "Unable to determine root directory since tsserver didn't start correctly"
    return nil
  end

  return ts_client.config.root_dir
end

function M.find_command(command)
  if local_installations[command] then
    local root_dir = find_root_dir()
    local local_command = local_installations[command](root_dir, command)
    if vim.fn.executable(local_command) == 1 then
      return local_command
    end
  end

  if vim.fn.executable(command) == 1 then
    return command
  end
  return nil
end

return M

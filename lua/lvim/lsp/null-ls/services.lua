local M = {}

local Log = require "lvim.core.log"
local null_ls = require "null-ls"
local s = require "null-ls.sources"
local fmt = string.format

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

  if command and vim.fn.executable(command) == 1 then
    return command
  end
  return nil
end

function M.list_registered_providers_names(filetype)
  local available_sources = s.get_available(filetype)
  local registered = {}
  for _, source in ipairs(available_sources) do
    for method in pairs(source.methods) do
      registered[method] = registered[method] or {}
      table.insert(registered[method], source.name)
    end
  end
  return registered
end

function M.register_sources(configs, method)
  local sources, registered_names = {}, {}

  for _, config in ipairs(configs) do
    local cmd = config.exe or config.command
    local name = config.name or cmd:gsub("-", "_")
    local type = method == null_ls.methods.CODE_ACTION and "code_actions" or null_ls.methods[method]:lower()
    local source = type and null_ls.builtins[type][name]
    Log:debug(fmt("Received request to register source [%s] as a %s", cmd, type))
    if not source then
      Log:error("Not a valid command for a source: " .. name)
    elseif s.is_registered { command = cmd or name, method = method } then
      Log:trace "Skipping registering the source more than once"
    else
      local command = M.find_command(source._opts.command) or source._opts.command
      local compat_opts = {
        command = command,
        -- treat `args` as `extra_args` for backwards compatibility. Can otherwise use `generator_opts.args`
        extra_args = config.args or config.extra_args,
      }
      local opts = vim.tbl_deep_extend("keep", compat_opts, config)
      Log:debug("Registering source: " .. source.name)
      table.insert(sources, source.with(opts))
      vim.list_extend(registered_names, { name })
    end
  end

  null_ls.register { sources = sources }
  return registered_names
end

return M

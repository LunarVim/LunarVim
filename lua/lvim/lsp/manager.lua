local M = {}

local Log = require "lvim.core.log"
local lvim_lsp_utils = require "lvim.lsp.utils"

---Resolve the configuration for a server by merging with the default config
---@param server_name string
---@vararg any config table [optional]
---@return table
local function resolve_config(server_name, ...)
  local defaults = {
    on_attach = require("lvim.lsp").common_on_attach,
    on_init = require("lvim.lsp").common_on_init,
    on_exit = require("lvim.lsp").common_on_exit,
    capabilities = require("lvim.lsp").common_capabilities(),
  }

  local has_custom_provider, custom_config = pcall(require, "lvim/lsp/providers/" .. server_name)
  if has_custom_provider then
    Log:debug("Using custom configuration for requested server: " .. server_name)
    defaults = vim.tbl_deep_extend("force", defaults, custom_config)
  end

  defaults = vim.tbl_deep_extend("force", defaults, ...)

  return defaults
end

-- manually start the server and don't wait for the usual filetype trigger from lspconfig
local function buf_try_add(server_name, bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  require("lspconfig")[server_name].manager.try_add_wrapper(bufnr)
end

-- check if the manager autocomd has already been configured since some servers can take a while to initialize
-- this helps guarding against a data-race condition where a server can get configured twice
-- which seems to occur only when attaching to single-files
local function client_is_configured(server_name, ft)
  ft = ft or vim.bo.filetype
  local active_autocmds = vim.api.nvim_get_autocmds { event = "FileType", pattern = ft }
  for _, result in ipairs(active_autocmds) do
    if result.command:match(server_name) then
      Log:debug(string.format("[%q] is already configured", server_name))
      return true
    end
  end
  return false
end

local function launch_server(server_name, config)
  pcall(function()
    require("lspconfig")[server_name].setup(config)
    buf_try_add(server_name)
  end)
end

---Setup a language server by providing a name
---@param server_name string name of the language server
---@param user_config table? when available it will take predence over any default configurations
function M.setup(server_name, user_config)
  vim.validate { name = { server_name, "string" } }
  user_config = user_config or {}

  if lvim_lsp_utils.is_client_active(server_name) or client_is_configured(server_name) then
    return
  end

  local servers = require "nvim-lsp-installer.servers"
  local server_available, server = servers.get_server(server_name)

  if not server_available then
    local config = resolve_config(server_name, user_config)
    launch_server(server_name, config)
    return
  end

  local install_in_progress = false

  if not server:is_installed() then
    if lvim.lsp.automatic_servers_installation then
      Log:debug "Automatic server installation detected"
      server:install()
      install_in_progress = true
    else
      Log:debug(server.name .. " is not managed by the automatic installer")
    end
  end

  server:on_ready(function()
    if install_in_progress then
      vim.notify(string.format("Installation complete for [%s] server", server.name), vim.log.levels.INFO)
    end
    install_in_progress = false
    local config = resolve_config(server_name, server:get_default_options(), user_config)
    launch_server(server_name, config)
  end)
end

return M

local M = {}

local Log = require "core.log"
local lsp_utils = require "lsp.utils"

function M.init_defaults(languages)
  for _, entry in ipairs(languages) do
    if not lvim.lang[entry] then
      lvim.lang[entry] = {
        formatters = {},
        linters = {},
        lsp = {},
      }
    end
  end
end

local function is_overridden(server)
  local overrides = lvim.lsp.override
  if type(overrides) == "table" then
    if vim.tbl_contains(overrides, server) then
      return true
    end
  end
end

---Resolve the configuration for a server based on both common and user configuration
---@param name string
---@param user_config table [optional]
---@return table
local function resolve_config(name, user_config)
  local config = {
    on_attach = require("lsp").common_on_attach,
    on_init = require("lsp").common_on_init,
    capabilities = require("lsp").common_capabilities(),
  }

  local status_ok, custom_config = pcall(require, "lsp/providers/" .. name)
  if status_ok then
    Log:debug("Using custom configuration for requested server: " .. name)
    config = vim.tbl_deep_extend("force", config, custom_config)
  end

  if user_config then
    config = vim.tbl_deep_extend("force", config, user_config)
  end

  return config
end

---Setup a language server by providing a name
---@param server_name string name of the language server
---@param user_config table [optional] when available it will take predence over any default configurations
function M.setup(server_name, user_config)
  vim.validate { name = { server_name, "string" } }

  if lsp_utils.is_client_active(server_name) or is_overridden(server_name) then
    return
  end

  local config = resolve_config(server_name, user_config)
  local server_available, requested_server = require("nvim-lsp-installer.servers").get_server(server_name)

  local function ensure_installed(server)
    if server:is_installed() then
      return true
    end
    if not lvim.lsp.automatic_servers_installation then
      Log:debug(server.name .. " is not managed by the automatic installer")
      return false
    end
    Log:debug(string.format("Installing [%s]", server.name))
    server:install()
    vim.schedule(function()
      vim.cmd [[LspStart]]
    end)
  end

  if server_available and ensure_installed(requested_server) then
    requested_server:setup(config)
  else
    require("lspconfig")[server_name].setup(config)
  end
end

return M

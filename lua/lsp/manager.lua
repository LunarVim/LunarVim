local M = {}

local Log = require "core.log"
local lsp_utils = require "lsp.utils"

function M.init_defaults(languages)
  for _, entry in ipairs(languages) do
    if not lvim.lang[entry] then
      lvim.lang[entry] = {
        formatters = {},
        linters = {},
      }
    end
  end
end

local function is_overridden(server)
  local overrides = lvim.lsp.override
  if type(overrides) == "table" then
    if vim.tbl_contains(overrides, server) then
      return
    end
  end
end

function M.setup_server(server_name)
  vim.validate {
    name = { server_name, "string" },
  }

  if lsp_utils.is_client_active(server_name) or is_overridden(server_name) then
    return
  end

  local lsp_installer_servers = require "nvim-lsp-installer.servers"
  local server_available, requested_server = lsp_installer_servers.get_server(server_name)
  if server_available then
    if not requested_server:is_installed() then
      Log:debug(string.format("[%s] is not installed", server_name))
      if lvim.lsp.automatic_servers_installation then
        Log:debug(string.format("Installing [%s]", server_name))
        requested_server:install()
      else
        return
      end
    end
  end

  local default_config = {
    on_attach = require("lsp").common_on_attach,
    on_init = require("lsp").common_on_init,
    capabilities = require("lsp").common_capabilities(),
  }

  local status_ok, custom_config = pcall(require, "lsp/providers/" .. requested_server.name)
  if status_ok then
    local new_config = vim.tbl_deep_extend("force", default_config, custom_config)
    Log:debug("Using custom configuration for requested server: " .. requested_server.name)
    requested_server:setup(new_config)
  else
    Log:debug("Using the default configuration for requested server: " .. requested_server.name)
    requested_server:setup(default_config)
  end
end

function M.setup(servers)
  local status_ok, _ = pcall(require, "nvim-lsp-installer")
  if not status_ok then
    return
  end

  --- allow using a single value
  if type(servers) == "string" then
    servers = { servers }
  end

  for _, server in ipairs(servers) do
    M.setup_server(server)
  end
end

return M

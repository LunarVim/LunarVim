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

function M.setup_server(server, default_config)
  vim.validate {
    name = { server.name, "string" },
    default_config = { default_config, "table" },
  }
  if lsp_utils.is_client_active(server) or is_overridden(server.name) then
    return
  end
  local status_ok, custom_config = pcall(require, "lsp/providers/" .. server.name)
  local new_config
  if status_ok then
    new_config = vim.tbl_deep_extend("keep", vim.empty_dict(), custom_config)
    new_config = vim.tbl_deep_extend("keep", new_config, default_config)
    Log:debug("Using custom configuration for server: " .. server.name)
    server:setup(new_config)
  else
    Log:debug("Using the default configuration for server: " .. server.name)
    server:setup(default_config)
  end
end

function M.setup(servers)
  local status_ok, ls_installer = pcall(require, "nvim-lsp-installer")
  if not status_ok then
    return
  end

  --- allow using a single value
  if type(servers) == "string" then
    servers = { servers }
  end

  local missing_servers = {}
  for _, server in ipairs(servers) do
    local lsp_installer_servers = require "nvim-lsp-installer.servers"
    local server_available, requested_server = lsp_installer_servers.get_server(server)
    if server_available then
      if not requested_server:is_installed() then
        table.insert(missing_servers, server)
      end
    end
  end

  -- TODO: this should handled more elegantly #1632
  if #vim.tbl_keys(missing_servers) == #vim.tbl_keys(servers) then
    Log:info(
      "None of the supported language server(s) [" .. table.concat(missing_servers, ", ") .. "] is currently installed"
    )
  end

  ls_installer.on_server_ready(function(server)
    local default_config = {
      on_attach = require("lsp").common_on_attach,
      on_init = require("lsp").common_on_init,
      capabilities = require("lsp").common_capabilities(),
    }
    M.setup_server(server, default_config)
  end)
end

return M

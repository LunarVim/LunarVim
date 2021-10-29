local M = {}

local Log = require "lvim.core.log"
local lvim_lsp_utils = require "lvim.lsp.utils"

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

---Resolve the configuration for a server based on both common and user configuration
---@param name string
---@param user_config table [optional]
---@return table
local function resolve_config(name, user_config)
  local config = {
    on_attach = require("lvim.lsp").common_on_attach,
    on_init = require("lvim.lsp").common_on_init,
    capabilities = require("lvim.lsp").common_capabilities(),
  }

  local has_custom_provider, custom_config = pcall(require, "lvim/lsp/providers/" .. name)
  if has_custom_provider then
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

  if lvim_lsp_utils.is_client_active(server_name) then
    return
  end
  local installer = require "nvim-lsp-installer"
  local servers = require "nvim-lsp-installer.servers"

  local config = resolve_config(server_name, user_config)
  local server_available, requested_server = servers.get_server(server_name)

  if server_available then
    -- until server:on_ready() fn exists upstream
    function requested_server:on_ready(cb)
      installer.on_server_ready(function(server)
        if server.name == server_name then
          cb()
        end
      end)
    end

    requested_server:on_ready(function()
      requested_server:setup(config)
      local delay_ms = 1000
      vim.defer_fn(function()
        installer.info_window.close()
      end, delay_ms)
    end)

    if not requested_server:is_installed() then
      if lvim.lsp.automatic_servers_installation then
        Log:info(string.format("Automatic server installation detected. Installing [%s]", requested_server.name))
        installer.info_window.open()
        requested_server:install()
      else
        Log:debug(requested_server.name .. " is not managed by the automatic installer")
      end
    end
  else
    -- since it may not be installed, don't attempt to configure the LSP unless there is a custom provider
    local has_custom_provider, _ = pcall(require, "lvim/lsp/providers/" .. server_name)
    if has_custom_provider then
      require("lspconfig")[server_name].setup(config)
    end
  end
end

return M

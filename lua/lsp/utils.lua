local M = {}

function M.is_client_active(name)
  local clients = vim.lsp.get_active_clients()
  for _, client in pairs(clients) do
    if client.name == name then
      return true, client
    end
  end
  return false
end

function M.disable_formatting_capability(client)
  -- FIXME: figure out a reasonable way to do this
  client.resolved_capabilities.document_formatting = false
  require("core.log"):debug(string.format("Turning off formatting capability for language server [%s] ", client.name))
end

function M.get_active_client_by_ft(filetype)
  local matches = {}
  local clients = vim.lsp.get_active_clients()
  for _, client in pairs(clients) do
    local supported_filetypes = client.config.filetypes or {}
    if client.name ~= "null-ls" and vim.tbl_contains(supported_filetypes, filetype) then
      table.insert(matches, client)
    end
  end
  return matches
end

function M.get_ls_capabilities(client_id)
  if not client_id then
    local buf_clients = vim.lsp.buf_get_clients()
    for _, buf_client in ipairs(buf_clients) do
      if buf_client.name ~= "null-ls" then
        client_id = buf_client.id
        break
      end
    end
  end
  if not client_id then
    error "Unable to determine client_id"
    return
  end

  local client = vim.lsp.get_client_by_id(tonumber(client_id))

  local enabled_caps = {}
  for capability, status in pairs(client.resolved_capabilities) do
    if status == true then
      table.insert(enabled_caps, capability)
    end
  end

  return enabled_caps
end

function M.get_supported_filetypes(server_name)
  -- print("got filetypes query request for: " .. server_name)
  local configs = require "lspconfig/configs"
  pcall(require, ("lspconfig/" .. server_name))
  for _, config in pairs(configs) do
    if config.name == server_name then
      return config.document_config.default_config.filetypes or {}
    end
  end
end

return M

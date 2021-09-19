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
-- FIXME: this should return a list instead
function M.get_active_client_by_ft(filetype)
  if not lvim.lang[filetype] or not lvim.lang[filetype].lsp then
    return nil
  end

  local clients = vim.lsp.get_active_clients()
  for _, client in pairs(clients) do
    if client.name == lvim.lang[filetype].lsp.provider then
      return client
    end
  end
  return nil
end

function M.get_ls_capabilities(client_id)
  local client
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
  end

  client = vim.lsp.get_client_by_id(tonumber(client_id))

  local enabled_caps = {}

  for k, v in pairs(client.resolved_capabilities) do
    if v == true then
      table.insert(enabled_caps, k)
    end
  end

  return enabled_caps
end

return M

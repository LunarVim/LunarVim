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

function M.get_all_supported_servers()
  return {
    "bashls",
    "beancount",
    "bicep",
    "clangd",
    "clojure_lsp",
    "cmake",
    "crystalline",
    "cssls",
    -- "dartls",
    "dockerls",
    "elixirls",
    "elmls",
    "erlangls",
    "fortls",
    "gdscript",
    "gopls",
    "graphql",
    "hls",
    "html",
    "intelephense",
    -- "jdtls",
    "jsonls",
    "julials",
    "kotlin_language_server",
    "metals",
    "omnisharp",
    "powershell_es",
    "puppet",
    "pyright",
    "r_language_server",
    "rnix",
    "rust_analyzer",
    "serve_d",
    "solang",
    "solargraph",
    "sourcekit",
    "sqls",
    "sumneko_lua",
    "svelte",
    "tailwindcss",
    "terraformls",
    "texlab",
    "tsserver",
    "vimls",
    "vuels",
    "yamlls",
    "zls",
  }
end

return M

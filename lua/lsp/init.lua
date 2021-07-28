local utils = require "utils"
local lsp_config = {}

function lsp_config.config()
  require("lsp.kind").setup()
  require("lsp.handlers").setup()
  require("lsp.signs").setup()
  require("lsp.keybinds").setup()
  require("core.autocmds").define_augroups {
    _general_lsp = {
      { "FileType", "lspinfo", "nnoremap <silent> <buffer> q :q<CR>" },
    },
  }
end

local function no_formatter_on_attach(client, bufnr)
  if lvim.lsp.on_attach_callback then
    lvim.lsp.on_attach_callback(client, bufnr)
  end
  require("lsp.utils").lsp_highlight_document(client)
  client.resolved_capabilities.document_formatting = false
end

function lsp_config.setup(lang)
  local lang_server = lvim.lang[lang].lsp
  local provider = lang_server.provider
  if require("utils").check_lsp_client_active(provider) then
    return
  end

  local overrides = lvim.lsp.override

  if utils.is_table(overrides) then
    if utils.has_value(overrides, lang) then
      return
    end
  end

  if utils.is_string(overrides) then
    if overrides == lang then
      return
    end
  end
  local sources = require("lsp.null-ls").setup(lang)

  for _, source in pairs(sources) do
    local method = source.method
    local format_method = "NULL_LS_FORMATTING"

    if utils.is_table(method) then
      if utils.has_value(method, format_method) then
        lang_server.setup.on_attach = no_formatter_on_attach
      end
    end

    if utils.is_string(method) then
      if method == format_method then
        lang_server.setup.on_attach = no_formatter_on_attach
      end
    end
  end

  if provider == "" or provider == nil then
    return
  end

  require("lspconfig")[provider].setup(lang_server.setup)
end

return lsp_config

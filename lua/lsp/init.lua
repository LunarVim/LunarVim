local utils = require "utils"
local service = require "lsp.service"
local lspconfig = require "lspconfig"
local null_ls = require "lsp.null-ls"
local M = {}

function M.config()
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

function M.setup(lang)
  local lang_server = lvim.lang[lang].lsp
  local provider = lang_server.provider
  if utils.check_lsp_client_active(provider) then
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
  local sources = null_ls.setup(lang)

  for _, source in pairs(sources) do
    local method = source.method
    local format_method = "NULL_LS_FORMATTING"

    if utils.is_table(method) then
      if utils.has_value(method, format_method) then
        lang_server.setup.on_attach = service.no_formatter_on_attach
      end
    end

    if utils.is_string(method) then
      if method == format_method then
        lang_server.setup.on_attach = service.no_formatter_on_attach
      end
    end
  end

  if provider == "" or provider == nil then
    return
  end

  lspconfig[provider].setup(lang_server.setup)
end

return M

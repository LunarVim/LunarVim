local M = {}
local service = require "lsp.service"

M.config = function()
  local constant = require "lsp.constant"
  local utils = require "utils"

  for _, sign in ipairs(constant.signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  -- symbols for autocomplete
  vim.lsp.protocol.CompletionItemKind = constant.completion_item_kind

  if lvim.lsp.default_keybinds then
    utils.add_keymap_normal_mode({ noremap = true, silent = true }, constant.mappings.normal_mode)
    -- scroll down hover doc or scroll in definition preview
    -- scroll up hover doc
    vim.cmd 'command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()'
  end

  -- Java
  -- autocmd FileType java nnoremap ca <Cmd>lua require('jdtls').code_action()<CR>
  require("core.autocmds").define_augroups(constant.augroups)

  -- Set Default Prefix.
  -- Note: You can set a prefix per lsp server in the lv-globals.lua file
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = lvim.lsp.diagnostics.virtual_text,
    signs = lvim.lsp.diagnostics.signs,
    underline = lvim.lsp.document_highlight,
  })

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = lvim.lsp.popup_border,
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = lvim.lsp.popup_border,
  })
end

M.setup = function(lang)
  local lsp = lvim.lang[lang].lsp
  if require("utils").check_lsp_client_active(lsp.provider) then
    return
  end

  local overrides = lvim.lsp.override
  if
    (type(overrides) == "table" and vim.tbl_contains(overrides, lang))
    or (type(overrides) == "string" and overrides == lang)
  then
    return
  end

  local null_ls = require "null-ls"
  local sources = require("lsp.null-ls").setup(lang)
  for _, source in pairs(sources) do
    local method = source.method
    if
      (type(method) == "table" and vim.tbl_contains(method, null_ls.methods.FORMATTING))
      or (type(method) == "string" and method == null_ls.methods.FORMATTING)
    then
      lsp.setup.on_attach = service.no_formatter_on_attach
    end
  end

  local lspconfig = require "lspconfig"
  if not lspconfig[lsp.provider] then
    return
  end

  lspconfig[lsp.provider].setup(lsp.setup)
end

return M

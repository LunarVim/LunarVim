local lsp_config = {}

function lsp_config.config()
  require("lsp.kind").setup()
  require("lsp.handlers").setup()
  require("lsp.signs").setup()
end

-- My font didn't like this :/
-- vim.api.nvim_set_keymap(
--   "n",
--   "gl",
--   '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ show_header = false, border = { { "🭽", "FloatBorder" }, { "▔", "FloatBorder" }, { "🭾", "FloatBorder" }, { "▕", "FloatBorder" }, { "🭿", "FloatBorder" }, { "▁", "FloatBorder" }, { "🭼", "FloatBorder" }, { "▏", "FloatBorder" }, } })<CR>',
--   { noremap = true, silent = true }
-- )

function lsp_config.setup_default_bindings()
  if lvim.lsp.default_keybinds then
    vim.cmd "nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>"
    vim.cmd "nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>"
    vim.cmd "nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>"
    vim.cmd "nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>"
    vim.api.nvim_set_keymap(
      "n",
      "gl",
      '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ show_header = false, border = "single" })<CR>',
      { noremap = true, silent = true }
    )

    vim.cmd "nnoremap <silent> gp <cmd>lua require'lsp.utils'.PeekDefinition()<CR>"
    vim.cmd "nnoremap <silent> K :lua vim.lsp.buf.hover()<CR>"
    vim.cmd "nnoremap <silent> <C-p> :lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = lvim.lsp.popup_border}})<CR>"
    vim.cmd "nnoremap <silent> <C-n> :lua vim.lsp.diagnostic.goto_next({popup_opts = {border = lvim.lsp.popup_border}})<CR>"
    -- vim.cmd "nnoremap <silent> <tab> <cmd>lua vim.lsp.buf.signature_help()<CR>"
    -- scroll down hover doc or scroll in definition preview
    -- scroll up hover doc
    -- vim.cmd 'command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()'
  end
end

local function no_formatter_on_attach(client, bufnr)
  if lvim.lsp.on_attach_callback then
    lvim.lsp.on_attach_callback(client, bufnr)
  end
  require("lsp.utils").lsp_highlight_document(client)
  client.resolved_capabilities.document_formatting = false
end

function lsp_config.common_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }
  return capabilities
end

require("core.autocmds").define_augroups {
  _general_lsp = {
    { "FileType", "lspinfo", "nnoremap <silent> <buffer> q :q<CR>" },
  },
}

local function is_table(t)
  return type(t) == "table"
end

local function is_string(t)
  return type(t) == "string"
end

local function has_value(tab, val)
  for _, value in ipairs(tab) do
    if value == val then
      return true
    end
  end

  return false
end

function lsp_config.setup(lang)
  local lang_server = lvim.lang[lang].lsp
  local provider = lang_server.provider
  if require("utils").check_lsp_client_active(provider) then
    return
  end

  local overrides = lvim.lsp.override

  if is_table(overrides) then
    if has_value(overrides, lang) then
      return
    end
  end

  if is_string(overrides) then
    if overrides == lang then
      return
    end
  end
  local sources = require("lsp.null-ls").setup(lang)

  for _, source in pairs(sources) do
    local method = source.method
    local format_method = "NULL_LS_FORMATTING"

    if is_table(method) then
      if has_value(method, format_method) then
        lang_server.setup.on_attach = no_formatter_on_attach
      end
    end

    if is_string(method) then
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

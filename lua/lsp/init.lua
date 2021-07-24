local lsp_config = {}

vim.fn.sign_define(
  "LspDiagnosticsSignError",
  { texthl = "LspDiagnosticsSignError", text = "", numhl = "LspDiagnosticsSignError" }
)
vim.fn.sign_define(
  "LspDiagnosticsSignWarning",
  { texthl = "LspDiagnosticsSignWarning", text = "", numhl = "LspDiagnosticsSignWarning" }
)
vim.fn.sign_define(
  "LspDiagnosticsSignHint",
  { texthl = "LspDiagnosticsSignHint", text = "", numhl = "LspDiagnosticsSignHint" }
)
vim.fn.sign_define(
  "LspDiagnosticsSignInformation",
  { texthl = "LspDiagnosticsSignInformation", text = "", numhl = "LspDiagnosticsSignInformation" }
)

-- local opts = { border = "single" }
-- TODO revisit this
-- local border = {
--   { "🭽", "FloatBorder" },
--   { "▔", "FloatBorder" },
--   { "🭾", "FloatBorder" },
--   { "▕", "FloatBorder" },
--   { "🭿", "FloatBorder" },
--   { "▁", "FloatBorder" },
--   { "🭼", "FloatBorder" },
--   { "▏", "FloatBorder" },
-- }

-- My font didn't like this :/
-- vim.api.nvim_set_keymap(
--   "n",
--   "gl",
--   '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ show_header = false, border = { { "🭽", "FloatBorder" }, { "▔", "FloatBorder" }, { "🭾", "FloatBorder" }, { "▕", "FloatBorder" }, { "🭿", "FloatBorder" }, { "▁", "FloatBorder" }, { "🭼", "FloatBorder" }, { "▏", "FloatBorder" }, } })<CR>',
--   { noremap = true, silent = true }
-- )

if O.lsp.default_keybinds then
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

  vim.cmd "nnoremap <silent> gp <cmd>lua require'lsp'.PeekDefinition()<CR>"
  vim.cmd "nnoremap <silent> K :lua vim.lsp.buf.hover()<CR>"
  vim.cmd "nnoremap <silent> <C-p> :lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = O.lsp.popup_border}})<CR>"
  vim.cmd "nnoremap <silent> <C-n> :lua vim.lsp.diagnostic.goto_next({popup_opts = {border = O.lsp.popup_border}})<CR>"
  vim.cmd "nnoremap <silent> <tab> <cmd>lua vim.lsp.buf.signature_help()<CR>"
  -- scroll down hover doc or scroll in definition preview
  -- scroll up hover doc
  vim.cmd 'command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()'
end

-- Set Default Prefix.
-- Note: You can set a prefix per lsp server in the lv-globals.lua file
function lsp_config.setup_handlers()
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = O.lsp.diagnostics.virtual_text,
    signs = O.lsp.diagnostics.signs,
    underline = O.lsp.document_highlight,
  })

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = O.lsp.popup_border,
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = O.lsp.popup_border,
  })
end

-- symbols for autocomplete
vim.lsp.protocol.CompletionItemKind = {
  "   (Text) ",
  "   (Method)",
  "   (Function)",
  "   (Constructor)",
  " ﴲ  (Field)",
  "[] (Variable)",
  "   (Class)",
  " ﰮ  (Interface)",
  "   (Module)",
  " 襁 (Property)",
  "   (Unit)",
  "   (Value)",
  " 練 (Enum)",
  "   (Keyword)",
  "   (Snippet)",
  "   (Color)",
  "   (File)",
  "   (Reference)",
  "   (Folder)",
  "   (EnumMember)",
  " ﲀ  (Constant)",
  " ﳤ  (Struct)",
  "   (Event)",
  "   (Operator)",
  "   (TypeParameter)",
}

--[[ " autoformat
autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil, 100) ]]
-- Java
-- autocmd FileType java nnoremap ca <Cmd>lua require('jdtls').code_action()<CR>

local function lsp_highlight_document(client)
  if O.lsp.document_highlight == false then
    return -- we don't need further
  end
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceText cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

-- Taken from https://www.reddit.com/r/neovim/comments/gyb077/nvimlsp_peek_defination_javascript_ttserver/
function lsp_config.preview_location(location, context, before_context)
  -- location may be LocationLink or Location (more useful for the former)
  context = context or 15
  before_context = before_context or 0
  local uri = location.targetUri or location.uri
  if uri == nil then
    return
  end
  local bufnr = vim.uri_to_bufnr(uri)
  if not vim.api.nvim_buf_is_loaded(bufnr) then
    vim.fn.bufload(bufnr)
  end

  local range = location.targetRange or location.range
  local contents = vim.api.nvim_buf_get_lines(
    bufnr,
    range.start.line - before_context,
    range["end"].line + 1 + context,
    false
  )
  local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
  return vim.lsp.util.open_floating_preview(contents, filetype, { border = O.lsp.popup_border })
end

function lsp_config.preview_location_callback(_, method, result)
  local context = 15
  if result == nil or vim.tbl_isempty(result) then
    print("No location found: " .. method)
    return nil
  end
  if vim.tbl_islist(result) then
    lsp_config.floating_buf, lsp_config.floating_win = lsp_config.preview_location(result[1], context)
  else
    lsp_config.floating_buf, lsp_config.floating_win = lsp_config.preview_location(result, context)
  end
end

function lsp_config.PeekDefinition()
  if vim.tbl_contains(vim.api.nvim_list_wins(), lsp_config.floating_win) then
    vim.api.nvim_set_current_win(lsp_config.floating_win)
  else
    local params = vim.lsp.util.make_position_params()
    return vim.lsp.buf_request(0, "textDocument/definition", params, lsp_config.preview_location_callback)
  end
end

function lsp_config.PeekTypeDefinition()
  if vim.tbl_contains(vim.api.nvim_list_wins(), lsp_config.floating_win) then
    vim.api.nvim_set_current_win(lsp_config.floating_win)
  else
    local params = vim.lsp.util.make_position_params()
    return vim.lsp.buf_request(0, "textDocument/typeDefinition", params, lsp_config.preview_location_callback)
  end
end

function lsp_config.PeekImplementation()
  if vim.tbl_contains(vim.api.nvim_list_wins(), lsp_config.floating_win) then
    vim.api.nvim_set_current_win(lsp_config.floating_win)
  else
    local params = vim.lsp.util.make_position_params()
    return vim.lsp.buf_request(0, "textDocument/implementation", params, lsp_config.preview_location_callback)
  end
end

function lsp_config.common_on_attach(client, bufnr)
  if O.lsp.on_attach_callback then
    O.lsp.on_attach_callback(client, bufnr)
  end
  lsp_highlight_document(client)
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

function lsp_config.tsserver_on_attach(client, _)
  -- lsp_config.common_on_attach(client, bufnr)
  client.resolved_capabilities.document_formatting = false

  local ts_utils = require "nvim-lsp-ts-utils"

  -- defaults
  ts_utils.setup {
    debug = false,
    disable_commands = false,
    enable_import_on_completion = false,
    import_all_timeout = 5000, -- ms

    -- eslint
    eslint_enable_code_actions = true,
    eslint_enable_disable_comments = true,
    -- eslint_bin = O.lang.tsserver.linter,
    eslint_config_fallback = nil,
    eslint_enable_diagnostics = true,

    -- formatting
    enable_formatting = O.lang.tsserver.autoformat,
    formatter = O.lang.tsserver.formatter.exe,
    formatter_config_fallback = nil,

    -- parentheses completion
    complete_parens = false,
    signature_help_in_parens = false,

    -- update imports on file move
    update_imports_on_move = false,
    require_confirmation_on_move = false,
    watch_dir = nil,
  }

  -- required to fix code action ranges
  ts_utils.setup_client(client)

  -- TODO: keymap these?
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", {silent = true})
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "qq", ":TSLspFixCurrent<CR>", {silent = true})
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", {silent = true})
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", {silent = true})
end

require("lv-utils").define_augroups {
  _general_lsp = {
    { "FileType", "lspinfo", "nnoremap <silent> <buffer> q :q<CR>" },
  },
}

function lsp_config.setup(lang)
  lang_server = O.lang[lang].lsp
  require("lsp.null-ls").setup "python"
  local provider = lang_server.provider
  if require("lv-utils").check_lsp_client_active(provider) then
    return
  end
  require("lspconfig")[provider].setup(lang_server.setup)
  require("lsp.null-ls").setup(lang)
end

return lsp_config

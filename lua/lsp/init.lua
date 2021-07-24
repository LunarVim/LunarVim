local M = {}

function M.config()
  require("lsp.kind").setup()
  require("lsp.handlers").setup()
  require("lsp.signs").setup()
end

local function lsp_highlight_document(client)
  if lvim.lsp.document_highlight == false then
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

local function formatter_handler(client)
  local buffer_filetype = vim.bo.filetype

  if not client.resolved_capabilities.document_formatting then
    lvim.lang[buffer_filetype].formatter.override_lsp = true
    -- error "Unable to format with LSP. Using null-ls instead"
    return
  end

  if lvim.lang[buffer_filetype].formatter.override_lsp then
    client.resolved_capabilities.document_formatting = false
    -- error "Override flag detected. Using null-ls for formatting"
  end
end

function M.common_capabilities()
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

function M.common_on_init(client, bufnr)
  if lvim.lsp.on_init_callback then
    lvim.lsp.on_init_callback(client, bufnr)
    return
  end
  formatter_handler(client)
end

function M.common_on_attach(client, bufnr)
  if lvim.lsp.on_attach_callback then
    lvim.lsp.on_attach_callback(client, bufnr)
  end
  lsp_highlight_document(client)
  require("lsp.keybinds").setup()
  require("lsp.null-ls").setup(vim.bo.filetype)
end

function M.setup(lang)
  local lang_server = lvim.lang[lang].lsp
  local provider = lang_server.provider
  if require("utils").check_lsp_client_active(provider) then
    return
  end

  require("lspconfig")[provider].setup(lang_server.setup)
end

return M

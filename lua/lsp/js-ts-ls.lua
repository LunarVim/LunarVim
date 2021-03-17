-- npm install -g typescript typescript-language-server
-- require'snippets'.use_suggested_mappings()

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true;
local on_attach_common = function(client)
    --print("LSP Initialized")
    -- require'completion'.on_attach(client)
    require'illuminate'.on_attach(client)
end

require'lspconfig'.tsserver.setup{
    on_attach = function(client)
        on_attach_common(client)
    end,
}

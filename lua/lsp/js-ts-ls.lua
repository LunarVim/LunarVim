-- npm install -g typescript typescript-language-server
require'snippets'.use_suggested_mappings()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true;
require'lspconfig'.tsserver.setup{
    capabilities = capabilities,
    on_attach = on_attach
}

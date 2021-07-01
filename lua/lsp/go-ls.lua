require'lspconfig'.gopls.setup {
    cmd = {DATA_PATH .. "/lspinstall/go/gopls"},
    settings = {gopls = {analyses = {unusedparams = true}, staticcheck = true}},
    root_dir = require'lspconfig'.util.root_pattern(".git", "go.mod"),
    init_options = {usePlaceholders = true, completeUnimported = true},
    on_attach = require'lsp'.common_on_attach
}

if O.lang.go.autoformat then
    require('lv-utils').define_augroups({
        _go_format = {
            {'BufWritePre', '*.go', 'lua vim.lsp.buf.formatting_sync(nil,1000)'}
        },
        _go = {
            -- Go generally requires Tabs instead of spaces.
            {'FileType', 'go', 'setlocal tabstop=4'},
            {'FileType', 'go', 'setlocal shiftwidth=4'},
            {'FileType', 'go', 'setlocal softtabstop=4'},
            {'FileType', 'go', 'setlocal noexpandtab'}
        }
    })
end

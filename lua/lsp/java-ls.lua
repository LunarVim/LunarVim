-- In Vimscript
-- augroup lsp
--   au!
--   au FileType java lua require('jdtls').start_or_attach({cmd = {'java-linux-ls'}})
-- augroup end
-- find_root looks for parent directories relative to the current buffer containing one of the given arguments.
-- require'lspconfig'.jdtls.setup {cmd = {'java-linux-ls'}}
if vim.fn.has("mac") == 1 then
    JAVA_LS_EXECUTABLE = 'java-mac-ls'
elseif vim.fn.has("unix") == 1 then
    JAVA_LS_EXECUTABLE = 'java-linux-ls'
else
    print("Unsupported system")
end
require('jdtls').start_or_attach({
    on_attach = require'lsp'.common_on_attach,
    cmd = {JAVA_LS_EXECUTABLE},
    root_dir = require('jdtls.setup').find_root({'gradle.build', 'pom.xml'})
})

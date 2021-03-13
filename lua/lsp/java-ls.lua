-- In Vimscript
-- augroup lsp
--   au!
--   au FileType java lua require('jdtls').start_or_attach({cmd = {'java-linux-ls'}})
-- augroup end
-- find_root looks for parent directories relative to the current buffer containing one of the given arguments.
-- require'lspconfig'.jdtls.setup {cmd = {'java-linux-ls'}}
require('jdtls').start_or_attach({cmd = {'java-linux-ls'}, root_dir = require('jdtls.setup').find_root({'gradle.build', 'pom.xml'})})

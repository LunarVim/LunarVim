require('default-config')
vim.cmd('luafile ' .. CONFIG_PATH .. '/lv-config.lua')
require('settings')
require('plugins')
require('lv-utils')
require('lv-autocommands')
require('keymappings')
require('colorscheme') -- This plugin must be required somewhere after nvimtree. Placing it before will break navigation keymappings
require('lv-galaxyline')
require('lv-telescope')
require('lv-treesitter')
require('lv-autopairs')
require('lv-which-key')

-- TODO gotta get rid of this for speed
vim.cmd('source ' .. CONFIG_PATH .. '/vimscript/functions.vim')

-- LSP
require('lsp')
-- TODO should I put this in the filetype files?
if O.lang.java.active then require('lsp.java-ls') end
if O.lang.clang.active then require('lsp.clangd') end
if O.lang.sh.active then require('lsp.bash-ls') end
if O.lang.cmake.active then require('lsp.cmake-ls') end
if O.lang.css.active then require('lsp.css-ls') end
if O.lang.dart.active then require('lsp.dart-ls') end
if O.lang.docker.active then require('lsp.docker-ls') end
if O.lang.efm.active then require('lsp.efm-general-ls') end
if O.lang.elm.active then require('lsp.elm-ls') end
if O.lang.emmet.active then require('lsp.emmet-ls') end
if O.lang.graphql.active then require('lsp.graphql-ls') end
if O.lang.go.active then require('lsp.go-ls') end
if O.lang.html.active then require('lsp.html-ls') end
if O.lang.json.active then require('lsp.json-ls') end
if O.lang.kotlin.active then require('lsp.kotlin-ls') end
if O.lang.latex.active then require('lsp.latex-ls') end
if O.lang.lua.active then require('lsp.lua-ls') end
if O.lang.php.active then require('lsp.php-ls') end
if O.lang.python.active then require('lsp.python-ls') end
if O.lang.ruby.active then require('lsp.ruby-ls') end
if O.lang.rust.active then require('lsp.rust-ls') end
if O.lang.svelte.active then require('lsp.svelte-ls') end
if O.lang.terraform.active then require('lsp.terraform-ls') end
if O.lang.tailwindcss.active then require('lsp.tailwindcss-ls') end
if O.lang.vim.active then require('lsp.vim-ls') end
if O.lang.yaml.active then require('lsp.yaml-ls') end
if O.lang.elixer.active then require('lsp.elixer-ls') end
if O.lang.tsserver.active then
    require('lsp.js-ts-ls')
    require('lsp.angular-ls')
    require('lsp.vue-ls')
end

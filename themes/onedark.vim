" onedark.vim override: Don't set a background color when running in a terminal;
" if (has("autocmd") && !has("gui_running"))
"   augroup colorset
"     autocmd!
"     let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
"     autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
"   augroup END
" endif

"autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting

let g:onedark_hide_endofbuffer=1
let g:onedark_terminal_italics=1
let g:onedark_termcolors=256

hi Comment cterm=italic
syntax on
colorscheme onedark

set termguicolors

hi CocHighlightText guibg=#31353f gui=none
hi CocErrorHighlight guifg=#efefef  guibg=#f4384b
hi CursorLine guibg=#22282f
" gui=undercurl term=undercurl
hi CocWarningHighlight guifg=#efefef guibg=#F4ab39
" gui=undercurl term=undercurl

hi Visual guibg=#38404b gui=none

highlight Cursor guibg=#6c778d

highlight TSType guifg=#e5c07b
highlight TSTypeBuiltin guifg=#e5c07b
highlight TSProperty guifg=#e06c75
highlight TSVariable guifg=#e06c75
highlight TSParameter guifg=#e06c75
highlight TSMethod guifg=#c678dd
highlight TSConstructor guifg=#e5c07b
highlight TSConstant guifg=#e5c07b
highlight TSMethod guifg=#61afef
highlight TSOperator guifg=#56b6c2
highlight TSLabel guifg=#e06c75
highlight TSPunctSpecial guifg=#c678dd

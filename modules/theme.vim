
" Switch to whatever colorscheme you like
"colorscheme onedark
""colorscheme gruvbox
colorscheme codedark

" This chunk is just for spacevim theme
"colorscheme space-vim-dark
"let g:space_vim_dark_background = 235
"color space-vim-dark

" gray comments
""hi Comment guifg=#5C6370 ctermfg=59
" this will show italics if your terminal supports that
hi Comment cterm=italic

" checks if your terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif

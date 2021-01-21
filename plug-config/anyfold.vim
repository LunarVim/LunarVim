let ftToIgnore = []
autocmd Filetype * if index(ftToIgnore, &ft) < 0 | AnyFoldActivate

let g:anyfold_fold_comments=1
set foldlevel=99

hi Folded guibg=#3e4551 guifg=#efefef

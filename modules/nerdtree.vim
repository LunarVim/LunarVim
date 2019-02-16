let NERDTreeShowHidden = 1              " show hidden files

" automatically close when you open a file"
"let NERDTreeQuitOnOpen = 1

" let nvim close when nerdtree is last thing"
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" nerdtree will delete buffer of file "

 let NERDTreeAutoDeleteBuffer = 1

" if you need help press ? while in nerdtree "
""let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1


"This depends on vim-nerdtree-syntax-highlight"
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name

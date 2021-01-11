let g:NERDCreateDefaultMappings = 0
let g:NERDRemoveExtraSpaces = 0
let g:NERDDefaultAlign = 'left'
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDCompactSexyComs = 1

" comment with ctrl+#
nnoremap <C-\> :call NERDComment(0,"toggle")<CR>
vnoremap <C-\> :call NERDComment(0,"toggle")<CR>

autocmd FileType javascript.jsx setlocal commentstring={/*\ %s\ */}

let g:colorizer_syntax = 1
let g:colorizer_auto_filetype='js,css,html,jsx,ts,tsx'
au BufNewFile,BufRead *.css,*.html,*.htm,*.js,*.jsx,*.ts,*.tsx  :ColorHighlight!


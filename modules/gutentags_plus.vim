" enable gtags module
let g:gutentags_modules = ['ctags', 'gtags_cscope']

" config project root markers.
let g:gutentags_project_root = ['.root', '.git']

" generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_cache_dir = expand('~/.cache/tags')

" change focus to quickfix window after search (optional).
""let g:gutentags_plus_switch = 1

" This will ignore everything in .gitignore"
let g:gutentags_file_list_command = 'rg --files'

"Install ripgrep"
"Install ctags"
".notags will ignore everything"

" I think this is built in but it's nice to know that if yo
" have ripgrep ctags will ignore everyhting in your .gitignore
if executable('rg')
  let g:gutentags_file_list_command = 'rg --files'
endif

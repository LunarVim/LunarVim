"Enable ale linters"
let g:ale_linters = {
    \ 'cpp' : ['gcc'],
    \ 'c' : ['gcc'],
    \ 'vim' : ['~/.miniconda/envs/neovim/bin/vint'],
    \ 'python': [],
    \ 'javascript': []
    \}
    "\ 'python': ['pyls','pydocstyle', 'pycodestyle'],

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['yapf'],
\}

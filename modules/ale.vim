"Enable ale linters"
let g:ale_linters = {
    \ 'cpp' : ['gcc'],
    \ 'c' : ['gcc'],
    \ 'vim' : ['vint'],
    \ 'python': ['pyls', 'pydocstyle', 'pycodestyle', 'vulture'],
    \ 'javascript': ['eslint']
    \}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['yapf'],
\}

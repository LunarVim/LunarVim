let g:ale_disable_lsp = 1

nmap <silent> <C-E> <Plug>(ale_next_wrap)

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_warnings = l:counts.total - l:all_errors

    let l:errors_recap = l:all_errors == 0 ? '' : printf('%d⨉ ', all_errors)
    let l:warnings_recap = l:all_warnings == 0 ? '' : printf('%d⚠ ', all_warnings)
    return (errors_recap . warnings_recap)
endfunction

set statusline+=%=
set statusline+=\ %{LinterStatus()}

let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1

let g:ale_sign_error = '✘'
let g:ale_sign_warning = '❗️'
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

let g:ale_sign_column_always = 1


let g:ale_fix_on_save = 1
" Check Python files with flake8 and pylint.
let g:ale_linters = {
            \'python': ['pyright', 'mypy', 'flake8', 'pylint'],
            \}
" Fix Python files with black and isort.
let g:ale_fixers = {'python': ['black', 'autopep8', 'isort']}

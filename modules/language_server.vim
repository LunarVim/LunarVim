" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_autoStart = 1

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'python': ['pyls'], 
    \ 'sh': ['bash-language-server', 'start'],
    \ 'c' : ['cquery'],
    \ 'cpp' : ['cquery'],
    \ }

nnoremap <silent> <leader>gh :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> <leader>gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <leader>gr :call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> <leader>gc :call LanguageClient_contextMenu()<CR>
nnoremap <silent> <leader>fr :call LanguageClient_textDocument_references()<CR>
nnoremap <silent> <leader>fix :call LanguageClient#textDocument_formatting()<CR>

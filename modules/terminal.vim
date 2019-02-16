" I am experimenting with different ways to use the terminal in nvim "
" So far I hate all my options

let s:term_buf = 0
let s:term_win = 0

function! Term_toggle(height)
    if win_gotoid(s:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . s:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let s:term_buf = bufnr("")
        endtry
        startinsert!
        let s:term_win = win_getid()
    endif
endfunction

nnoremap <silent> <M-t> :call Term_toggle(10)<cr>
tnoremap <silent> <M-t> <C-\><C-n>:call Term_toggle(10)<cr>

let wiki_1 = {}
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'
"set concealcursor=nc
let g:vimwiki_list = [{'path': '~/wiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

" TAB in general mode will move to text buffer
nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>

let g:indentLine_setConceal = 0
let g:indentLine_concealcursor = ""
set conceallevel=0


"let g:vimwiki_list = [{'path': '~/wiki/', 'index': 'main'}]
"Key bindings
"Normal mode:

"<Leader>ww -- Open default wiki index file.
"<Leader>wt -- Open default wiki index file in a new tab.
"<Leader>ws -- Select and open wiki index file.
"<Leader>wd -- Delete wiki file you are in.
"<Leader>wr -- Rename wiki file you are in.
"<Enter> -- Follow/Create wiki link
"<Shift-Enter> -- Split and follow/create wiki link
"<Ctrl-Enter> -- Vertical split and follow/create wiki link
"<Backspace> -- Go back to parent(previous) wiki link
"<Tab> -- Find next wiki link
"<Shift-Tab> -- Find previous wiki link
"For more keys, see :h vimwiki-mappings

"Commands
":Vimwiki2HTML -- Convert current wiki link to HTML
":VimwikiAll2HTML -- Convert all your wiki links to HTML
":help vimwiki-commands -- list all commands
":help vimwiki -- General vimwiki help docs

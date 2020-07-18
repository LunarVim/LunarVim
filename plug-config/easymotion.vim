" let g:EasyMotion_do_mapping = 0 " Disable default mappings
" " Turn on case-insensitive feature
" let g:EasyMotion_smartcase = 1

" " JK motions: Line motions
" map <Leader>j <Plug>(easymotion-j)
" map <Leader>k <Plug>(easymotion-k)

" nmap s <Plug>(easymotion-s2)
" nmap t <Plug>(easymotion-t2)

" TODO add separate section for vscode

" map  <Leader>f <Plug>(easymotion-bd-f)
" nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
if exists('g:vscode')
  " VSCode extension
  nmap s <Plug>(easymotion-f3)
  nmap <Leader>s <Plug>(easymotion-f2)
else
  " ordinary neovim
  nmap s <Plug>(easymotion-overwin-f2)
endif

" nmap X <Plug>(easymotion-overwin-t)
map f <Plug>(easymotion-lineforward)
nmap F <Plug>(easymotion-linebackward)

" Move to line
if exists('g:vscode')
  map <Leader>l <Plug>(easymotion-bd-jk)
  nmap <Leader>l <Plug>(easymotion-overwin-line)

  " Move to word
  map  <Leader>w <Plug>(easymotion-bd-w)
  nmap <Leader>w <Plug>(easymotion-overwin-w)
endif

hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment

hi link EasyMotionTarget2First MatchParen
hi link EasyMotionTarget2Second MatchParen

hi link EasyMotionMoveHL Search
hi link EasyMotionIncSearch Search

"Lower case finds upper & lower case but upper case only finds upper case
let g:EasyMotion_smartcase = 1

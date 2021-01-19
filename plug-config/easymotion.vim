" let g:EasyMotion_do_mapping = 0 " Disable default mappings
" " Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1
let g:EasyMotion_verbose = 0
let g:EasyMotion_do_shade = 0

autocmd User EasyMotionPromptBegin silent! CocDisable
autocmd User EasyMotionPromptEnd silent! CocEnable

" " JK motions: Line motions
" map <Leader>j <Plug>(easymotion-j)
" map <Leader>k <Plug>(easymotion-k)

" nmap s <Plug>(easymotion-s2)
" nmap t <Plug>(easymotion-t2)

nmap s <Plug>(easymotion-f2)
nmap S <Plug>(easymotion-F2)
" s{char}{char} to move to {char}{char}
" if exists('g:vscode')
"   " VSCode extension
"   nmap s <Plug>(easymotion-f2)
"   nmap G <Plug>(easymotion-F2)
"   else
"   " ordinary neovim
"   nmap s <Plug>(easymotion-overwin-f2)
"   nmap G <Plug>(easymotion-overwin-F2)
" endif

nmap f <Plug>(easymotion-f)
nmap F <Plug>(easymotion-F)
nmap t <Plug>(easymotion-t)
nmap T <Plug>(easymotion-T)

" Move to line
if exists('g:vscode')
  map <Leader>l <Plug>(easymotion-bd-jk)

  " Move to word
  map  <Leader>w <Plug>(easymotion-bd-w)
  nmap <Leader>w <Plug>(easymotion-overwin-w)

endif

" hi link EasyMotionTarget ErrorMsg

" hi link EasyMotionTarget2First MatchParen

" hi link EasyMotionMoveHL Search

" hi link EasyMotionTarget ErrorMsg

" hi link EasyMotionTarget2First MatchParen

" hi link EasyMotionMoveHL Search

let g:EasyMotion_prompt = '🔎 '


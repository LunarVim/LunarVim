
"Make window a little bigger"
"
let g:goyo_width=100
let g:goy_height=95
"
"
" Disable Deoplete "

function! s:goyo_enter()
  
  call deoplete#custom#option('auto_complete', v:false)
  set spell spelllang=en_us
  set wrap
  set tw=100
  set noshowcmd
  set scrolloff=999
""  set background=light
""  colorscheme flattened_light
  Limelight
  " ...
endfunction

function! s:goyo_leave()

  call deoplete#custom#option('auto_complete', v:true)
  set nospell
  set wrap!
  set showcmd
  set scrolloff=5
""  set background=dark
""  colorscheme Tender
  Limelight!
  " ...
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()



"Make window a little bigger"
"
let g:goyo_width=100
let g:goy_height=95
"
"
" Disable Deoplete "

function! s:goyo_enter()
  
  "call deoplete#custom#option('auto_complete', v:false)
  set spell spelllang=en_us
  set wrap
  set conceallevel=0
  set tw=100
  set noshowcmd
  set scrolloff=999
""  set background=light
""  colorscheme flattened_light
  "Limelight
  " ...
endfunction

function! s:goyo_leave()

  "call deoplete#custom#option('auto_complete', v:true)
  set nospell
  set wrap!
  set showcmd
  set scrolloff=5
""  set background=dark
""  colorscheme Tender
  "Limelight!
  " ...
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

" Default: 0.5
let g:limelight_default_coefficient = 0.7

" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 0

" Beginning/end of paragraph
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1

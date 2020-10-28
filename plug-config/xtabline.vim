let g:xtabline_settings = {}

let g:xtabline_settings.enable_mappings = 0

let g:xtabline_settings.tabline_modes = ['buffers', 'tabs']

let g:xtabline_settings.enable_persistance = 0

" let g:xtabline_settings.last_open_first = 1
let g:xtabline_lazy = 1

let g:xtabline_settings.show_right_corner = 0

let g:xtabline_settings.indicators = {
      \ 'modified': '+',
      \ 'pinned': '[📌]',
      \}
      " \ 'modified': '●',

let g:xtabline_settings.icons = {
      \'pin': '📌',
      \'star': '*',
      \'book': '📖',
      \'lock': '🔒',
      \'hammer': '🔨',
      \'tick': '✔',
      \'cross': '✖',
      \'warning': '⚠',
      \'menu': '☰',
      \'apple': '🍎',
      \'linux': '🐧',
      \'windows': '⌘',
      \'git': '',
      \'palette': '🎨',
      \'lens': '🔍',
      \'flag': '🏁',
      \}

" let g:which_key_map.T = {
"       \ 'name' : '+tabline' ,
"       \ 'b' : [':XTabListBuffers'         , 'list buffers'],
"       \ 'd' : [':XTabCloseBuffer'         , 'close buffer'],
"       \ 'D' : [':XTabDeleteTab'           , 'close tab'],
"       \ 'h' : [':XTabHideBuffer'          , 'hide buffer'],
"       \ 'i' : [':XTabInfo'                , 'info'],
"       \ 'l' : [':XTabLock'                , 'lock tab'],
"       \ 'm' : [':XTabMode'                , 'toggle mode'],
"       \ 'n' : [':tabNext'                 , 'next tab'],
"       \ 'N' : [':XTabMoveBufferNext'      , 'buffer->'],
"       \ 't' : [':tabnew'                  , 'new tab'],
"       \ 'p' : [':tabprevious'             , 'prev tab'],
"       \ 'P' : [':XTabMoveBufferPrev'      , '<-buffer'],
"       \ 'x' : [':XTabPinBuffer'           , 'pin buffer'],
"       \ }

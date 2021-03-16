" Leader Key Maps

" Timeout
let g:which_key_timeout = 100

let g:which_key_display_names = {'<CR>': '↵', '<TAB>': '⇆'}

" Map leader to which_key
nnoremap <silent> <leader> :silent <c-u> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

let g:which_key_map =  {}
let g:which_key_sep = '→'

" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0
let g:which_key_max_size = 0

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler


" Single mappings
" let g:which_key_map['/'] = [ ':call Comment()'                                 , 'comment' ]
" let g:which_key_map['/'] = { 'name' : 'comment' }
let g:which_key_map['/'] = 'which_key_ignore'
let g:which_key_map['?'] = [ ':NvimTreeFindFile'                               , 'find current file' ]
let g:which_key_map['e'] = [ ':NvimTreeToggle'                                 , 'explorer' ]
let g:which_key_map['h'] = [ '<C-W>s'                                          , 'split below']
let g:which_key_map['n'] = [ ':let @/ = ""'                                    , 'no highlight' ]
let g:which_key_map['r'] = [ ':RnvimrToggle'                                   , 'ranger' ]
" TODO create entire treesitter section
let g:which_key_map['T'] = [ ':TSHighlightCapturesUnderCursor'                 , 'treesitter highlight' ]
let g:which_key_map['v'] = [ '<C-W>v'                                          , 'split right']
" Add Zen mode, play nice with status line
" let g:which_key_map['z'] = [ 'Goyo'                                            , 'zen' ]

" Group mappings

" a is for actions
let g:which_key_map.a = {
      \ 'name' : '+actions' ,
      \ 'c' : [':ColorizerToggle'        , 'colorizer'],
      \ 'e' : [':CocCommand explorer'    , 'explorer'],
      \ 'h' : [':let @/ = ""'            , 'remove search highlight'],
      \ 'l' : [':Bracey'                 , 'start live server'],
      \ 'L' : [':BraceyStop'             , 'stop live server'],
      \ 'm' : [':MarkdownPreview'        , 'markdown preview'],
      \ 'M' : [':MarkdownPreviewStop'    , 'markdown preview stop'],
      \ 'n' : [':set nonumber!'          , 'line-numbers'],
      \ 's' : [':s/\%V\(.*\)\%V/"\1"/'   , 'surround'],
      \ 'r' : [':set norelativenumber!'  , 'relative line nums'],
      \ 't' : [':FloatermToggle'         , 'terminal'],
      \ 'v' : [':Codi'                   , 'virtual repl on'],
      \ 'V' : [':Codi!'                  , 'virtual repl off'],
      \ 'w' : [':StripWhitespace'        , 'strip whitespace'],
      \ }

b is for buffer
let g:which_key_map.b = {
      \ 'name' : '+buffer' ,
      \ '>' : [':BufferMoveNext'        , 'move next'],
      \ '<' : [':BufferMovePrevious'    , 'move prev'],
      \ 'b' : [':BufferPick'            , 'pick buffer'],
      \ 'd' : [':Bdelete'               , 'delete-buffer'],
      \ 'n' : ['bnext'                  , 'next-buffer'],
      \ 'p' : ['bprevious'              , 'previous-buffer'],
      \ '?' : ['Buffers'                , 'fzf-buffer'],
      \ }


" F is for fold
let g:which_key_map.F = {
    \ 'name': '+fold',
    \ 'O' : [':set foldlevel=20', 'open all'],
    \ 'C' : [':set foldlevel=0', 'close all'],
    \ 'c' : [':foldclose', 'close'],
    \ 'o' : [':foldopen', 'open'],
    \ '1' : [':set foldlevel=1', 'level1'],
    \ '2' : [':set foldlevel=2', 'level2'],
    \ '3' : [':set foldlevel=3', 'level3'],
    \ '4' : [':set foldlevel=4', 'level4'],
    \ '5' : [':set foldlevel=5', 'level5'],
    \ '6' : [':set foldlevel=6', 'level6']
    \ }

" s is for search powered by telescope
let g:which_key_map.s = {
      \ 'name' : '+search' ,
      \ '.' : [':Telescope filetypes'                   , 'filetypes'],
      \ ';' : [':Telescope commands'                    , 'commands'],
      \ 'a' : [':Telescope lsp_code_actions'            , 'code_actions'],
      \ 'A' : [':Telescope builtin'                     , 'all'],
      \ 'b' : [':Telescope buffers'                     , 'buffers'],
      \ 'B' : [':Telescope git_branches'                , 'git branches'],
      \ 'd' : [':Telescope lsp_document_diagnostics'    , 'document_diagnostics'],
      \ 'D' : [':Telescope lsp_workspace_diagnostics'   , 'workspace_diagnostics'],
      \ 'c' : [':Telescope git_commits'                 , 'git_commits'],
      \ 'C' : [':Telescope git_bcommits'                , 'git_bcommits'],
      \ 'f' : [':Telescope find_files'                  , 'files'],
      \ 'F' : [':Telescope git_files'                   , 'git_files'],
      \ 'g' : [':Telescope tags'                        , 'tags'],
      \ 'G' : [':Telescope current_buffer_tags'         , 'buffer_tags'],
      \ 'h' : [':Telescope command_history'             , 'history'],
      \ 'H' : [':Telescope help_tags'                   , 'help_tags'],
      \ 'i' : [':Telescope media_files'                 , 'media files'],
      \ 'k' : [':Telescope keymaps'                     , 'keymaps'],
      \ 'l' : [':Telescope loclist'                     , 'loclist'],
      \ 'm' : [':Telescope marks'                       , 'marks'],
      \ 'M' : [':Telescope man_pages'                   , 'man_pages'],
      \ 'o' : [':Telescope vim_options'                 , 'vim_options'],
      \ 'O' : [':Telescope oldfiles'                    , 'oldfiles'],
      \ 'p' : [':Telescope fd'                          , 'fd'],
      \ 'P' : [':Telescope spell_suggest'               , 'spell_suggest'],
      \ 's' : [':Telescope git_status'                  , 'git_status'],
      \ 'S' : [':Telescope grep_string'                 , 'grep_string'],
      \ 't' : [':Telescope live_grep'                   , 'text'],
      \ 'y' : [':Telescope symbols'                     , 'symbols'],
      \ 'Y' : [':Telescope lsp_workspace_symbols'       , 'lsp_workspace_symbols'],
      \ 'r' : [':Telescope registers'                   , 'registers'],
      \ 'R' : [':Telescope reloader'                    , 'reloader'],
      \ 'w' : [':Telescope file_browser'                , 'buf_fuz_find'],
      \ 'u' : [':Telescope colorscheme'                 , 'colorschemes'],
      \ 'z' : [':Telescope current_buffer_fuzzy_find'   , 'buf_fuz_find'],
      \ }

let g:which_key_map.S = {
      \ 'name' : '+Session' ,
      \ 'c' : [':SClose'          , 'Close Session']  ,
      \ 'd' : [':SDelete'         , 'Delete Session'] ,
      \ 'l' : [':SLoad'           , 'Load Session']     ,
      \ 's' : [':Startify'        , 'Start Page']     ,
      \ 'S' : [':SSave'           , 'Save Session']   ,
      \ }

" g is for git
let g:which_key_map.g = {
      \ 'name' : '+git' ,
      \ 'b' : [':GitBlameToggle'                   , 'blame'],
      \ 'B' : [':GBrowse'                          , 'browse'],
      \ 'd' : [':Git diff'                         , 'diff'],
      \ 'i' : [':Gist -b'                          , 'post gist'],
      \ 'l' : [':Git log'                          , 'log'],
      \ 'S' : [':Gstatus'                          , 'status'],
      \ }
      " set these up for git signs
      "     ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
      "     ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

      "     ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
      "     ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
      "     ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
      "     ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
      "     ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
      "     ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',
      " \ 'p' : [':Git push'                         , 'push'],
      " \ 'P' : [':Git pull'                         , 'pull'],
      " \ 'g' : [':GGrep'                            , 'git grep'],
      " \ 'D' : [':Gdiffsplit'                       , 'diff split'],
      " \ 'c' : [':Git commit'                       , 'commit'],
      " \ 'A' : [':CocCommand fzf-preview.GitStatus' , 'actions'],
      " \ 'a' : [':Git add .'                        , 'add all'],
      " \ 'A' : [':Git add %'                        , 'add current'],
      " \ 'S' : [':!git status'                      , 'status'],

let g:which_key_map.G = {
      \ 'name' : '+gist' ,
      \ 'b' : [':Gist -b'                          , 'post gist browser'],
      \ 'd' : [':Gist -d'                          , 'delete gist'],
      \ 'e' : [':Gist -e'                          , 'edit gist'],
      \ 'l' : [':Gist -l'                          , 'list public gists'],
      \ 's' : [':Gist -ls'                         , 'list starred gists'],
      \ 'm' : [':Gist -m'                          , 'post gist all buffers'],
      \ 'p' : [':Gist -P'                          , 'post public gist '],
      \ 'P' : [':Gist -p'                          , 'post private gist '],
      \ }
      " \ 'a' : [':Gist -a'                          , 'post gist anon'],

" l is for language server protocol
let g:which_key_map.l = {
      \ 'name' : '+lsp' ,
      \ 'a' : [':Lspsaga code_action'                , 'quickfix'],
      \ 'A' : [':Lspsaga range_code_action'          , 'selected action'],
      \ 'd' : [':Telescope lsp_document_diagnostics' , 'document diagnostics'],
      \ 'D' : [':Telescope lsp_workspace_diagnostics', 'workspace diagnostics'],
      \ 'f' : [':LspFormatting'                      , 'format'],
      \ 'H' : [':Lspsaga signature_help'             , 'signature_help'],
      \ 'I' : [':LspInfo'                            , 'lsp_info'],
      \ 'l' : [':Lspsaga lsp_finder'                 , 'lsp_finder'],
      \ 'L' : [':Lspsaga show_line_diagnostics'      , 'line_diagnostics'],
      \ 'o' : [':Vista!!'                            , 'outline'],
      \ 'p' : [':Lspsaga preview_definition'         , 'preview definition'],
      \ 'q' : [':Telescope quickfix'                 , 'quickfix'],
      \ 'r' : [':LspRename'                          , 'rename'],
      \ 'T' : [':LspTypeDefinition'                  , 'type defintion'],
      \ 'x' : [':cclose'                             , 'close quickfix'],
      \ 's' : [':Telescope lsp_document_symbols'     , 'document symbols'],
      \ 'S' : [':Telescope lsp_workspace_symbols'    , 'workspace symbols'],
      \ }

" t is for terminal
let g:which_key_map.t = {
      \ 'name' : '+terminal' ,
      \ ';' : [':FloatermNew --wintype=normal --height=6'       , 'terminal'],
      \ 'f' : [':FloatermNew fzf'                               , 'fzf'],
      \ 'g' : [':FloatermNew lazygit'                           , 'git'],
      \ 'd' : [':FloatermNew lazydocker'                        , 'docker'],
      \ 'n' : [':FloatermNew node'                              , 'node'],
      \ 'N' : [':FloatermNew nnn'                               , 'nnn'],
      \ 'p' : [':FloatermNew python'                            , 'python'],
      \ 'm' : [':FloatermNew lazynpm'                           , 'npm'],
      \ 'r' : [':FloatermNew ranger'                            , 'ranger'],
      \ 't' : [':FloatermToggle'                                , 'toggle'],
      \ 'y' : [':FloatermNew ytop'                              , 'ytop'],
      \ 'u' : [':FloatermNew ncdu'                              , 'ncdu'],
      \ }

call which_key#register('<Space>', "g:which_key_map")

"    ____      _ __        _
"   /  _/___  (_) /__   __(_)___ ___
"   / // __ \/ / __/ | / / / __ `__ \
" _/ // / / / / /__| |/ / / / / / / /
"/___/_/ /_/_/\__(_)___/_/_/ /_/ /_/


" Always source these
source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/general/functions.vim
source $HOME/.config/nvim/keys/mappings.vim
source $HOME/.config/nvim/keys/which-key.vim
source $HOME/.config/nvim/general/paths.vim

" Source depending on if VSCode is our client
if exists('g:vscode')
    " VSCode extension
  source $HOME/.config/nvim/vscode/windows.vim
  source $HOME/.config/nvim/plug-config/easymotion.vim
else
  " ordinary neovim
  source $HOME/.config/nvim/themes/syntax.vim
  source $HOME/.config/nvim/themes/onedark.vim
  source $HOME/.config/nvim/themes/airline.vim
  source $HOME/.config/nvim/plug-config/rnvimr.vim
  source $HOME/.config/nvim/plug-config/fzf.vim
  source $HOME/.config/nvim/plug-config/nerd-commenter.vim
  source $HOME/.config/nvim/plug-config/rainbow.vim
  source $HOME/.config/nvim/plug-config/quickscope.vim
  source $HOME/.config/nvim/plug-config/sneak.vim
  source $HOME/.config/nvim/plug-config/coc.vim
  source $HOME/.config/nvim/plug-config/goyo.vim
  source $HOME/.config/nvim/plug-config/vim-rooter.vim
  source $HOME/.config/nvim/plug-config/start-screen.vim
  source $HOME/.config/nvim/plug-config/gitgutter.vim
  source $HOME/.config/nvim/plug-config/closetags.vim
  source $HOME/.config/nvim/plug-config/floaterm.vim
  source $HOME/.config/nvim/plug-config/vista.vim
  luafile $HOME/.config/nvim/lua/plug-colorizer.lua
  " source $HOME/.config/nvim/plug-config/easymotion.vim
endif

" Experimental

" Codi
let g:codi#rightalign=0

" VimWiki
  let g:vimwiki_key_mappings =
    \ {
    \   'all_maps': 0,
    \   'global': 0,
    \   'headers': 0,
    \   'text_objs': 0,
    \   'table_format': 0,
    \   'table_mappings': 0,
    \   'lists': 0,
    \   'links': 0,
    \   'html': 0,
    \   'mouse': 0,
    \ }

" Filetypes enabled for
let g:vimwiki_filetypes = ['markdown', 'pandoc']

let g:vimwiki_auto_header = 0
let g:vimwiki_markdown_header_style = 1
let g:vimwiki_tags_header_level = 1
let g:vimwiki_tags_header = 'Generated Tags'
let g:vimwiki_links_header_level = 1
let g:vimwiki_links_header = 'Generated Links'
let g:vimwiki_auto_chdir = 0
let g:vimwiki_map_prefix = '<Leader>w'
let g:vimwiki_toc_link_format = 0
let g:vimwiki_toc_header_level = 1
let g:vimwiki_toc_header = 'Contents'
let g:vimwiki_autowriteall = 1
let g:vimwiki_conceal_pre = 0
let g:vimwiki_conceal_onechar_markers = 1
let g:vimwiki_conceallevel = 2
let g:vimwiki_user_htmls = ''
let g:vimwiki_valid_html_tags = 'b,i,s,u,sub,sup,kbd,br,hr'
let g:vimwiki_html_header_numbering_sym = ''
let g:vimwiki_html_header_numbering = 0
let g:vimwiki_dir_link = ''
let g:vimwiki_markdown_link_ext = 0
let g:vimwiki_create_link = 1
let g:vimwiki_use_calendar = 1
let g:vimwiki_text_ignore_newline = 1
let g:vimwiki_list_ignore_newline = 1
let g:vimwiki_folding = ''
let g:vimwiki_listsym_rejected = '✗'
let g:vimwiki_listsyms = '✗○◐●✓'
let g:vimwiki_global_ext = 1
let g:vimwiki_hl_cb_checked = 0
let g:vimwiki_list = [{'path': '~/my_site/', 'exclude_files': ['**/README.md']}]




let g:vimwiki_diary_months = {
      \ 1: 'January', 2: 'February', 3: 'March',
      \ 4: 'April', 5: 'May', 6: 'June',
      \ 7: 'July', 8: 'August', 9: 'September',
      \ 10: 'October', 11: 'November', 12: 'December'
      \ }

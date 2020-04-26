" Syntax highlighting
let g:python_highlight_all=1

" Change this when you know where i3 will be
aug i3config_ft_detection
  au!
  au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
aug end

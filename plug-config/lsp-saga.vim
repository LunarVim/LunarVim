	" TODO find way to add doc abilities back for compe
  nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
  " -- scroll down hover doc or scroll in definition preview
  nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
  " -- scroll up hover doc
  nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
  " signature
  nnoremap <silent> gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>


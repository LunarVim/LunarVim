setl commentstring={/*%s*/}
setl ts=2
setl sw=2             
" autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
" autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()

setl commentstring={/*%s*/} ts=2 sw=2
" autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
" autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()
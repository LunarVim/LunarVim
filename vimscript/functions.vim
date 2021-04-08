command! LspCodeAction lua require 'nv-utils'.code_action()
command! LspDeclaration lua require 'nv-utils'.declaration()
command! LspDefinition lua require 'nv-utils'.definition()
command! LspDocumentSymbol lua require 'nv-utils'.document_symbol()
command! LspFormatting lua require 'nv-utils'.formatting()
command! LspFormattingSync lua require 'nv-utils'.formatting_sync()
command! LspHover lua require 'nv-utils'.hover()
command! LspImplementation lua require 'nv-utils'.implementation()
command! LspRangeCodeAction lua require 'nv-utils'.range_code_action()
command! LspRangeFormatting lua require 'nv-utils'.range_formatting()
command! LspReferences lua require 'nv-utils'.references()
command! LspRename lua require 'nv-utils'.rename()
command! LspTypeDefinition lua require 'nv-utils'.type_definition()
command! LspWorkspaceSymbol lua require 'nv-utils'.workspace_symbol()
command! LspGotoNext lua require 'nv-utils'.goto_next()
command! LspGotoPrev lua require 'nv-utils'.goto_prev()
command! LspShowLineDiagnostics lua require 'nv-utils'.show_line_diagnostics()
command! NextHunk lua require 'nv-utils'.next_hunk()
command! PrevHunk lua require 'nv-utils'.prev_hunk()
command! StageHunk lua require 'nv-utils'.stage_hunk()
command! UndoStageHunk lua require 'nv-utils'.undo_stage_hunk()
command! ResetHunk lua require 'nv-utils'.reset_hunk()
command! ResetBuffer lua require 'nv-utils'.reset_buffer()
command! PreviewHunk lua require 'nv-utils'.preview_hunk()
command! BlameLine lua require 'nv-utils'.blame_line()
command! W noa w

" Debugging
command! DebugToggleBreakpoint lua require'dap'.toggle_breakpoint()
command! DebugStart lua require'dap'.continue()
command! DebugContinue lua require'dap'.continue()
command! DebugStepOver lua require'dap'.step_over()
command! DebugStepOut lua require'dap'.step_out()
command! DebugStepInto lua require'dap'.step_into()
command! DebugToggleRepl lua require'dap'.repl.toggle()
command! DebugGetSession lua require'dap'.session()

" Available Debug Adapters:
"   https://microsoft.github.io/debug-adapter-protocol/implementors/adapters/
" 
" Adapter configuration and installation instructions:
"   https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
" 
" Debug Adapter protocol:
"   https://microsoft.github.io/debug-adapter-protocol/

" TODO Add full support later
" nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
" nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
" nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
" nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
" nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
" nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
" nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
" nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
" nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>

" TODO find out why this thing follows me everywhere in java
let blacklist = ['java']
autocmd CursorHold,CursorHoldI * if index(blacklist, &ft) < 0 | lua require'nvim-lightbulb'.update_lightbulb()

autocmd! User GoyoEnter lua require('gitsigns').toggle_signs()
autocmd! User GoyoLeave lua require('gitsigns').toggle_signs()

autocmd User GoyoEnter set laststatus=0 
autocmd User GoyoLeave set laststatus=2

" autocmd! User GoyoEnter lua require('galaxyline').disable_galaxyline()
" autocmd! User GoyoLeave lua require('galaxyline').galaxyline_augroup()

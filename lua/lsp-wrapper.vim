command! LspCodeAction lua require 'lsp-wrapper'.code_action()
command! LspDeclaration lua require 'lsp-wrapper'.declaration()
command! LspDefinition lua require 'lsp-wrapper'.definition()
command! LspDocumentSymbol lua require 'lsp-wrapper'.document_symbol()
command! LspFormatting lua require 'lsp-wrapper'.formatting()
command! LspFormattingSync lua require 'lsp-wrapper'.formatting_sync()
command! LspHover lua require 'lsp-wrapper'.hover()
command! LspImplementation lua require 'lsp-wrapper'.implementation()
command! LspRangeCodeAction lua require 'lsp-wrapper'.range_code_action()
command! LspRangeFormatting lua require 'lsp-wrapper'.range_formatting()
command! LspReferences lua require 'lsp-wrapper'.references()
command! LspRename lua require 'lsp-wrapper'.rename()
command! LspTypeDefinition lua require 'lsp-wrapper'.type_definition()
command! LspWorkspaceSymbol lua require 'lsp-wrapper'.workspace_symbol()
command! LspGotoNext lua require 'lsp-wrapper'.goto_next()
command! LspGotoPrev lua require 'lsp-wrapper'.goto_prev()
command! LspShowLineDiagnostics lua require 'lsp-wrapper'.show_line_diagnostics()
" command! LspAddToWorkspaceFolder lua require 'lsp-wrapper'.add_to_workspace_folder()
" command! LspRemoveWorkspaceFolder lua require 'lsp-wrapper'.remove_workspace_folder()
" command! LspListWorkspaceFolders lua require 'lsp-wrapper'.list_workspace_folders()
" command! LspClearReferences lua require 'lsp-wrapper'.clear_references()
" command! LspGetNext lua require 'lsp-wrapper'.get_next()
" command! LspGetPrev lua require 'lsp-wrapper'.get_prev()
" command! LspGetAll lua require 'lsp-wrapper'.get_all()
" command! LspIncomingCalls lua require 'lsp-wrapper'.incoming_calls()
" command! LspOutGoingCalls lua require 'lsp-wrapper'.outgoing_calls()
" command! LspDocumentHighlight lua require 'lsp-wrapper'.document_highlight()

" Java

" command! FileType java LspCodeAction <Esc><Cmd>lua require('jdtls').code_action(true)<CR>
" command! FileType java LspCodeAction <Esc><Cmd>lua require('jdtls').code_action(false, 'refactor')<CR>

" nnoremap <A-o> <Cmd>lua require'jdtls'.organize_imports()<CR>
" nnoremap crv <Cmd>lua require('jdtls').extract_variable()<CR>
" vnoremap crv <Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>
" vnoremap crm <Esc><Cmd>lua require('jdtls').extract_method(true)<CR>

local lsp_wrapper = {}

-- buf

function lsp_wrapper.add_to_workspace_folder()
  vim.lsp.buf.add_workspace_folder()
end

function lsp_wrapper.clear_references()
  vim.lsp.buf.clear_references()
end

function lsp_wrapper.code_action()
  vim.lsp.buf.code_action()
end

function lsp_wrapper.declaration()
  vim.lsp.buf.declaration()
  vim.lsp.buf.clear_references()
end

function lsp_wrapper.definition()
  vim.lsp.buf.definition()
  vim.lsp.buf.clear_references()
end

function lsp_wrapper.document_highlight()
  vim.lsp.buf.document_highlight()
end

function lsp_wrapper.document_symbol()
  vim.lsp.buf.document_symbol()
end

function lsp_wrapper.formatting()
  vim.lsp.buf.formatting()
end

function lsp_wrapper.formatting_sync()
  vim.lsp.buf.formatting_sync()
end

function lsp_wrapper.hover()
  vim.lsp.buf.hover()
end

function lsp_wrapper.implementation()
  vim.lsp.buf.implementation()
end

function lsp_wrapper.incoming_calls()
  vim.lsp.buf.incoming_calls()
end

function lsp_wrapper.list_workspace_folders()
  vim.lsp.buf.list_workspace_folders()
end

function lsp_wrapper.outgoing_calls()
  vim.lsp.buf.outgoing_calls()
end

function lsp_wrapper.range_code_action()
  vim.lsp.buf.range_code_action()
end

function lsp_wrapper.range_formatting()
  vim.lsp.buf.range_formatting()
end

function lsp_wrapper.references()
  vim.lsp.buf.references()
  vim.lsp.buf.clear_references()
end

function lsp_wrapper.remove_workspace_folder()
  vim.lsp.buf.remove_workspace_folder()
end

function lsp_wrapper.rename()
  vim.lsp.buf.rename()
end

function lsp_wrapper.signature_help()
  vim.lsp.buf.signature_help()
end

function lsp_wrapper.type_definition()
  vim.lsp.buf.type_definition()
end

function lsp_wrapper.workspace_symbol()
  vim.lsp.buf.workspace_symbol()
end

-- diagnostic

function lsp_wrapper.get_all()
  vim.lsp.diagnostic.get_all()
end

function lsp_wrapper.get_next()
  vim.lsp.diagnostic.get_next()
end

function lsp_wrapper.get_prev()
  vim.lsp.diagnostic.get_prev()
end

function lsp_wrapper.goto_next()
  vim.lsp.diagnostic.goto_next()
end

function lsp_wrapper.goto_prev()
  vim.lsp.diagnostic.goto_prev()
end

function lsp_wrapper.show_line_diagnostics()
  vim.lsp.diagnostic.show_line_diagnostics()
end

-- misc

-- :lua print(vim.inspect(vim.lsp.buf_get_clients()))

-- autoformat
-- autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)

return lsp_wrapper




-- You can see more about the differences in types here:
-- https://microsoft.github.io/language-server-protocol/specification#textDocument_documentHighlight

--                                                            *hl-LspReferenceText*
-- LspReferenceText          used for highlighting "text" references
--                                                            *hl-LspReferenceRead*
-- LspReferenceRead          used for highlighting "read" references
--                                                           *hl-LspReferenceWrite*
-- LspReferenceWrite         used for highlighting "write" references


--                                                    *lsp-highlight-diagnostics*
-- All highlights defined for diagnostics begin with `LspDiagnostics` followed by
-- the type of highlight (e.g., `Sign`, `Underline`, etc.) and then the Severity
-- of the highlight (e.g. `Error`, `Warning`, etc.)

-- Sign, underline and virtual text highlights (by default) are linked to their
-- corresponding LspDiagnosticsDefault highlight.

-- For example, the default highlighting for |hl-LspDiagnosticsSignError| is
-- linked to |hl-LspDiagnosticsDefaultError|. To change the default (and
-- therefore the linked highlights), use the |:highlight| command: >

--     highlight LspDiagnosticsDefaultError guifg="BrightRed"
-- <

--                                                *hl-LspDiagnosticsDefaultError*
-- LspDiagnosticsDefaultError
--   Used as the base highlight group.
--   Other LspDiagnostic highlights link to this by default (except Underline)

--                                              *hl-LspDiagnosticsDefaultWarning*
-- LspDiagnosticsDefaultWarning
--   Used as the base highlight group.
--   Other LspDiagnostic highlights link to this by default (except Underline)

--                                          *hl-LspDiagnosticsDefaultInformation*
-- LspDiagnosticsDefaultInformation
--   Used as the base highlight group.
--   Other LspDiagnostic highlights link to this by default (except Underline)

--                                                 *hl-LspDiagnosticsDefaultHint*
-- LspDiagnosticsDefaultHint
--   Used as the base highlight group.
--   Other LspDiagnostic highlights link to this by default (except Underline)

--                                            *hl-LspDiagnosticsVirtualTextError*
-- LspDiagnosticsVirtualTextError
--   Used for "Error" diagnostic virtual text.
--   See |vim.lsp.diagnostic.set_virtual_text()|

--                                          *hl-LspDiagnosticsVirtualTextWarning*
-- LspDiagnosticsVirtualTextWarning
--   Used for "Warning" diagnostic virtual text.
--   See |vim.lsp.diagnostic.set_virtual_text()|

--                                      *hl-LspDiagnosticsVirtualTextInformation*
-- LspDiagnosticsVirtualTextInformation
--   Used for "Information" diagnostic virtual text.
--   See |vim.lsp.diagnostic.set_virtual_text()|

--                                             *hl-LspDiagnosticsVirtualTextHint*
-- LspDiagnosticsVirtualTextHint
--   Used for "Hint" diagnostic virtual text.
--   See |vim.lsp.diagnostic.set_virtual_text()|

--                                              *hl-LspDiagnosticsUnderlineError*
-- LspDiagnosticsUnderlineError
--   Used to underline "Error" diagnostics.
--   See |vim.lsp.diagnostic.set_underline()|

--                                            *hl-LspDiagnosticsUnderlineWarning*
-- LspDiagnosticsUnderlineWarning
--   Used to underline "Warning" diagnostics.
--   See |vim.lsp.diagnostic.set_underline()|

--                                        *hl-LspDiagnosticsUnderlineInformation*
-- LspDiagnosticsUnderlineInformation
--   Used to underline "Information" diagnostics.
--   See |vim.lsp.diagnostic.set_underline()|

--                                               *hl-LspDiagnosticsUnderlineHint*
-- LspDiagnosticsUnderlineHint
--   Used to underline "Hint" diagnostics.
--   See |vim.lsp.diagnostic.set_underline()|

--                                               *hl-LspDiagnosticsFloatingError*
-- LspDiagnosticsFloatingError
--   Used to color "Error" diagnostic messages in diagnostics float.
--   See |vim.lsp.diagnostic.show_line_diagnostics()|

--                                             *hl-LspDiagnosticsFloatingWarning*
-- LspDiagnosticsFloatingWarning
--   Used to color "Warning" diagnostic messages in diagnostics float.
--   See |vim.lsp.diagnostic.show_line_diagnostics()|

--                                         *hl-LspDiagnosticsFloatingInformation*
-- LspDiagnosticsFloatingInformation
--   Used to color "Information" diagnostic messages in diagnostics float.
--   See |vim.lsp.diagnostic.show_line_diagnostics()|

--                                                *hl-LspDiagnosticsFloatingHint*
-- LspDiagnosticsFloatingHint
--   Used to color "Hint" diagnostic messages in diagnostics float.
--   See |vim.lsp.diagnostic.show_line_diagnostics()|

--                                                   *hl-LspDiagnosticsSignError*
-- LspDiagnosticsSignError
--   Used for "Error" signs in sign column.
--   See |vim.lsp.diagnostic.set_signs()|

--                                                 *hl-LspDiagnosticsSignWarning*
-- LspDiagnosticsSignWarning
--   Used for "Warning" signs in sign column.
--   See |vim.lsp.diagnostic.set_signs()|

--                                             *hl-LspDiagnosticsSignInformation*
-- LspDiagnosticsSignInformation
--   Used for "Information" signs in sign column.
--   See |vim.lsp.diagnostic.set_signs()|

--                                                    *hl-LspDiagnosticsSignHint*
-- LspDiagnosticsSignHint
--   Used for "Hint" signs in sign column.
--   See |vim.lsp.diagnostic.set_signs()|

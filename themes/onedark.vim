" onedark.vim override: Don't set a background color when running in a terminal;
" if (has("autocmd") && !has("gui_running"))
"   augroup colorset
"     autocmd!
"     let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
"     autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
"   augroup END
" endif

"autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting

let g:onedark_hide_endofbuffer=1
let g:onedark_terminal_italics=1
let g:onedark_termcolors=256

hi Comment cterm=italic
syntax on
colorscheme onedark

set termguicolors

hi CocHighlightText guibg=#31353f gui=none
hi CocErrorHighlight guibg=#1F0E0E
hi CocWarningHighlight guibg=#1E1C06
hi CursorLine guibg=#22282f

" gui=undercurl term=undercurl

hi Visual guibg=#38404b gui=none

highlight Cursor guibg=#6c778d

hi Normal guifg=#abb2bf ctermfg=249 guibg=#1e2127 ctermbg=235 gui=NONE cterm=NONE
hi Float guifg=#d19a66 ctermfg=173 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TSFloat guifg=#98c379 ctermfg=114 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi Terminal guifg=#abb2bf ctermfg=249 guibg=#1e1e1e ctermbg=234 gui=NONE cterm=NONE
hi EndOfBuffer guifg=#1e1e1e ctermfg=234 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TabLine guifg=#5c6370 ctermfg=241 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TabLineSel guifg=#abb2bf ctermfg=249 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi TabLineFill guifg=NONE ctermfg=NONE guibg=#1e2127 ctermbg=235 gui=NONE cterm=NONE
hi LineNr guifg=#4b5263 ctermfg=240 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi SignColumn guifg=NONE ctermfg=NONE guibg=#1e2127 ctermbg=235 gui=NONE cterm=NONE
hi MatchParen guifg=#61afef ctermfg=75 guibg=NONE ctermbg=NONE gui=underline cterm=underline
hi Delimiter guifg=#b0b0b0
hi IncSearch guifg=#e5c07b ctermfg=180 guibg=#5c6370 ctermbg=241 gui=NONE cterm=NONE

hi CocExplorerIndentLine guifg=#5c6370 ctermfg=241 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocExplorerBufferRoot guifg=#56b6c2 ctermfg=73 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocExplorerFileRoot guifg=#56b6c2 ctermfg=73 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocExplorerBufferFullPath guifg=#5c6370 ctermfg=241 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocExplorerFileFullPath guifg=#5c6370 ctermfg=241 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocExplorerBufferReadonly guifg=#c586c0 ctermfg=175 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocExplorerBufferModified guifg=#c586c0 ctermfg=175 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocExplorerBufferNameVisible guifg=#98c379 ctermfg=114 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocExplorerFileReadonly guifg=#c586c0 ctermfg=175 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocExplorerFileModified guifg=#c586c0 ctermfg=175 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocExplorerFileHidden guifg=#5c6370 ctermfg=241 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi CocExplorerHelpLine guifg=#c586c0 ctermfg=175 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi EasyMotionTarget guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi EasyMotionTarget2First guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi EasyMotionTarget2Second guifg=#f44747 ctermfg=203 guibg=NONE ctermbg=NONE gui=bold cterm=bold
hi EasyMotionShade guifg=NONE ctermfg=NONE guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi StartifyNumber guifg=#d19a66 ctermfg=173 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi StartifySelect guifg=#98c379 ctermfg=114 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi StartifyBracket guifg=#61afef ctermfg=75 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi StartifySpecial guifg=#56b6c2 ctermfg=73 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi StartifyVar guifg=#61afef ctermfg=75 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi StartifyPath guifg=#61afef ctermfg=75 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi StartifyFile guifg=#e06c75 ctermfg=168 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi StartifySlash guifg=#61afef ctermfg=75 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi StartifyHeader guifg=#98c379 ctermfg=114 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi StartifySection guifg=#c586c0 ctermfg=175 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi StartifyFooter guifg=#98c379 ctermfg=114 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi WhichKey guifg=#c586c0 ctermfg=175 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi WhichKeySeperator guifg=#98c379 ctermfg=114 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi WhichKeyGroup guifg=#61afef ctermfg=75 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi WhichKeyDesc guifg=#61afef ctermfg=75 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi diffAdded guifg=#98c379 ctermfg=114 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi diffRemoved guifg=#e06c75 ctermfg=168 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi diffFileId guifg=#61afef ctermfg=75 guibg=NONE ctermbg=NONE gui=bold,reverse cterm=bold,reverse
hi diffFile guifg=#3b4048 ctermfg=238 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi diffNewFile guifg=#98c379 ctermfg=114 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi diffOldFile guifg=#e06c75 ctermfg=168 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi debugPc guifg=NONE ctermfg=NONE guibg=#56b6c2 ctermbg=73 gui=NONE cterm=NONE
hi debugBreakpoint guifg=#e06c75 ctermfg=168 guibg=NONE ctermbg=NONE gui=reverse cterm=reverse


hi TSType guifg=#e5c07b
hi TSNamespace guifg=#e06c75
hi TSTypeBuiltin guifg=#e5c07b
hi TSProperty guifg=#e06c75
hi TSVariable guifg=#e06c75
hi TSParameter guifg=#e06c75
hi TSMethod guifg=#c678dd
hi TSKeyword guifg=#c678dd
hi TSInclude guifg=#c678dd
hi TSConstructor guifg=#e5c07b
hi TSConstant guifg=#e5c07b
hi TSPunctSpecial guifg=#e5c07b
hi TSKeywordOperator guifg=#c678dd
hi TSMethod guifg=#61afef
hi TSOperator guifg=#56b6c2
hi TSLabel guifg=#e06c75
hi TSPunctSpecial guifg=#c678dd
hi TSTagDelimiter guifg=#b0b0b0
hi TSDelimiter guifg=#b0b0b0
hi TSPunctBracket guifg=#FFD700
hi TSVariableBuiltin guifg=#e5c07b

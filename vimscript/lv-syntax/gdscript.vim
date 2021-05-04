" Vim syntax file for Godot gdscript
" Language:     gdscript
" Maintainer:   Maxim Kim <habamax@gmail.com>
" Filenames:    *.gd

if exists("b:current_syntax")
    finish
endif

syn keyword gdscriptConditional if else elif match switch case
syn keyword gdscriptRepeat for while break continue

syn keyword gdscriptOperator is as not and or in

if get(g:, "godot_ext_hl", v:true)
    syn match gdscriptClass "\v<\u\w+>"
    syn match gdscriptConstant "\<[_A-Z]\+[0-9_A-Z]*\>"
    syn match gdscriptOperator "\V&&\|||\|!\|&\|^\||\|~\|*\|/\|%\|+\|-\|=\|<\|>\|:"
    syn match gdscriptDelimiter "\V(\|)\|[\|]\|{\|}"
endif

syn keyword gdscriptKeyword null self owner parent tool
syn keyword gdscriptBoolean false true

syn keyword gdscriptStatement remote master puppet remotesync mastersync puppetsync sync
syn keyword gdscriptStatement return pass
syn keyword gdscriptStatement static const enum
syn keyword gdscriptStatement breakpoint assert
syn keyword gdscriptStatement onready
syn keyword gdscriptStatement class_name extends

syn keyword gdscriptType void bool int float contained

syn keyword gdscriptStatement var nextgroup=gdscriptTypeDecl skipwhite
syn match gdscriptTypeDecl "\h\w*\s*:\s*\h\w*" contains=gdscriptOperator,gdscriptType,gdscriptClass contained skipwhite
syn match gdscriptTypeDecl "->\s*\h\w*" contains=gdscriptOperator,gdscriptType,gdscriptClass skipwhite

syn keyword gdscriptStatement export nextgroup=gdscriptExportTypeDecl skipwhite
syn match gdscriptExportTypeDecl "(.\{-}[,)]" contains=gdscriptOperator,gdscriptType,gdscriptClass,gdscriptDelimiter contained skipwhite

syn keyword gdscriptStatement setget nextgroup=gdscriptSetGet,gdscriptSetGetSeparator skipwhite
syn match gdscriptSetGet "\h\w*" nextgroup=gdscriptSetGetSeparator display contained skipwhite
syn match gdscriptSetGetSeparator "," nextgroup=gdscriptSetGet display contained skipwhite

syn keyword gdscriptStatement class func signal nextgroup=gdscriptFunctionName skipwhite
syn match gdscriptFunctionName "\h\w*" nextgroup=gdscriptFunctionParams display contained skipwhite
syn match gdscriptFunctionParams "(.*)" contains=gdscriptDelimiter,gdscriptTypeDecl display contained skipwhite

if get(g:, "godot_ext_hl", v:true)
    syn match gdscriptFunctionCall "\v<\w*>\s*(\()@="
endif

syn match gdscriptNode "\$\h\w*\%(/\h\w*\)*"

syn match gdscriptComment "#.*$" contains=@Spell,gdscriptTodo

syn region gdscriptString matchgroup=gdscriptQuotes
      \ start=+[uU]\=\z(['"]\)+ end="\z1" skip="\\\\\|\\\z1"
      \ contains=gdscriptEscape,@Spell

syn region gdscriptString matchgroup=gdscriptTripleQuotes
      \ start=+[uU]\=\z('''\|"""\)+ end="\z1" keepend
      \ contains=gdscriptEscape,@Spell

syn match gdscriptEscape +\\[abfnrtv'"\\]+ contained
syn match gdscriptEscape "\\$"
syn match gdscriptBlockStart ":\s*$"

" Numbers
syn match gdscriptNumber "\<0[oO]\=\o\+[Ll]\=\>"
syn match gdscriptNumber "\<0[xX]\x\+[Ll]\=\>"
syn match gdscriptNumber "\<0[bB][01]\+[Ll]\=\>"
syn match gdscriptNumber "\<\%([1-9]\d*\|0\)[Ll]\=\>"
syn match gdscriptNumber "\<\d\+[jJ]\>"
syn match gdscriptNumber "\<\d\+[eE][+-]\=\d\+[jJ]\=\>"
syn match gdscriptNumber "\<\d\+\.\%([eE][+-]\=\d\+\)\=[jJ]\=\%(\W\|$\)\@="
syn match gdscriptNumber "\%(^\|\W\)\zs\d*\.\d\+\%([eE][+-]\=\d\+\)\=[jJ]\=\>"

" XXX, TODO, etc
syn keyword gdscriptTodo TODO XXX FIXME HACK NOTE BUG contained

hi def link gdscriptStatement Statement
hi def link gdscriptKeyword Keyword
hi def link gdscriptConditional Conditional
hi def link gdscriptBoolean Boolean
hi def link gdscriptOperator Operator
hi def link gdscriptRepeat Repeat
hi def link gdscriptSetGet Function
hi def link gdscriptFunctionName Function
if get(g:, "godot_ext_hl", v:true)
    hi def link gdscriptClass Type
    hi def link gdscriptFunctionCall Function
    hi def link gdscriptDelimiter Delimiter
    hi def link gdscriptConstant Constant
endif
hi def link gdscriptBuiltinStruct Typedef
hi def link gdscriptComment Comment
hi def link gdscriptString String
hi def link gdscriptQuotes String
hi def link gdscriptTripleQuotes String
hi def link gdscriptEscape Special
hi def link gdscriptNode PreProc
hi def link gdscriptType Type
hi def link gdscriptNumber Number
hi def link gdscriptBlockStart Special
hi def link gdscriptTodo Todo


let b:current_syntax = "gdscript"

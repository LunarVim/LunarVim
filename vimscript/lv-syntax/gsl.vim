" Vim syntax file for Godot shading language
" Language:     gsl
" Maintainer:   Shatur95 <genaloner@gmail.com>, Maxim Kim <habamax@gmail.com>
" Filenames:    *.shader

if exists("b:current_syntax")
    finish
endif

syn keyword gslConditional if else
syn keyword gslRepeat for while
syn keyword gslStatement return discard
syn keyword gslBoolean true false

syn keyword gslKeyword shader_type render_mode
syn keyword gslKeyword in out inout
syn keyword gslKeyword lowp mediump highp
syn keyword gslKeyword uniform varying const
syn keyword gslKeyword flat smooth

syn keyword gslType float vec2 vec3 vec4
syn keyword gslType uint uvec2 uvec3 uvec4
syn keyword gslType int ivec2 ivec3 ivec4
syn keyword gslType void bool
syn keyword gslType bvec2 bvec3 bvec4
syn keyword gslType mat2 mat3 mat4
syn keyword gslType sampler2D isampler2D usampler2D samplerCube

syn match gslOperator "\V&&\|||\|!\|&\|^\||\|~\|*\|/\|%\|+\|-\|=\|<\|>\|:\|;"
syn match gslDelimiter "\V(\|)\|[\|]\|{\|}"

syn match gslMember "\v<(\.)@<=[a-z_]+\w*>"
syn match gslBuiltin "\v<[A-Z_]+[A-Z0-9_]*>"
syn match gslFunction "\v<\w*>(\()@="

syn match gslNumber "\v<\d+(\.)@!>"
syn match gslFloat "\v<\d*\.\d+(\.)@!>"
syn match gslFloat "\v<\d*\.=\d+(e-=\d+)@="
syn match gslExponent "\v(\d*\.=\d+)@<=e-=\d+>"

syn match gslComment "\v//.*$"
syn region gslComment start="/\*" end="\*/"
syn keyword gslTodo TODO FIXME XXX NOTE BUG HACK OPTIMIZE containedin=gslComment

hi def link gslConditional Conditional
hi def link gslRepeat Repeat
hi def link gslOperator Operator
hi def link gslDelimiter Delimiter
hi def link gslStatement Statement
hi def link gslBoolean Boolean
hi def link gslKeyword Keyword
hi def link gslMember Identifier
hi def link gslBuiltin Identifier
hi def link gslFunction Function
hi def link gslType Type
hi def link gslNumber Number
hi def link gslFloat Float
hi def link gslExponent Special
hi def link gslComment Comment
hi def link gslTodo Todo

let b:current_syntax = "gsl"

local lush = require "lush"
local hsl = lush.hsl

local theme = lush(function()
  local c = {
    bg = hsl "#212121",
    bg1 = hsl "#2a2a2a",
    -- bg2 = hsl("#3a3a3a"),
    bg2 = hsl "#383d45",

    white = hsl "#c8c9d1",

    gray = hsl "#858585",
    light_gray = hsl "#c8c9c1",

    error_red = hsl "#F44747",
    warning_orange = hsl "#ff8800",
    info_yellow = hsl "#ffcc66",
    hint_blue = hsl "#4fc1ff",

    red = hsl "#b04b57",

    blue = hsl "#5486c0",
    gray_blue = hsl "#66899d",

    -- yellow = hsl("#ffcb6b"),
    yellow = hsl "#eeba5a",

    -- orange = hsl("#c98a75"),
    orange = hsl "#c6735a",

    green = hsl "#87b379",
    light_green = hsl "#b2d77c",

    -- aqua = hsl("#46b1d0"),
    aqua = hsl "#65a7c5",

    purple = hsl "#bf83c1",
    pale_purple = hsl "#7199ee",

    sign_add = hsl "#587C0C",
    sign_change = hsl "#0C7D9D",
    sign_delete = hsl "#94151B",

    test = hsl "#ff00ff",
  }
  return {
    Normal { bg = c.bg, fg = c.white, gui = "NONE" }, -- used for the columns set with 'colorcolumn'
    SignColumn { Normal },
    ModeMsg { Normal },
    MsgArea { Normal },
    MsgSeparator { Normal },
    SpellBad { bg = "NONE", fg = c.white, gui = "underline", sp = c.red },
    SpellCap { bg = "NONE", fg = c.white, gui = "underline", sp = c.yellow },
    SpellLocal { bg = "NONE", fg = c.white, gui = "underline", sp = c.green },
    SpellRare { bg = "NONE", fg = c.white, gui = "underline", sp = c.blue },
    NormalNC { Normal },
    Pmenu { bg = c.bg2, fg = c.white, gui = "NONE" },
    PmenuSel { bg = c.gray_blue, fg = c.bg1.da(5), gui = "NONE" },
    WildMenu { PmenuSel }, -- Non Defaults
    CursorLineNr { bg = "NONE", fg = c.light_gray, gui = "bold" },
    Comment { bg = "NONE", fg = c.gray, gui = "italic" }, -- any comment
    Folded { bg = c.bg1, fg = c.gray, gui = "NONE" },
    FoldColumn { Normal, fg = c.gray, gui = "NONE" },
    LineNr { bg = "NONE", fg = c.gray, gui = "NONE" },
    FloatBorder { bg = c.bg1, fg = c.gray, gui = "NONE" },
    Whitespace { bg = "NONE", fg = c.gray.da(35), gui = "NONE" },
    VertSplit { bg = "NONE", fg = c.bg2, gui = "NONE" },
    CursorLine { bg = c.bg1, fg = "NONE", gui = "NONE" },
    CursorColumn { CursorLine },
    ColorColumn { CursorLine },
    NormalFloat { bg = c.bg2.da(30), fg = "NONE", gui = "NONE" },
    Visual { bg = c.bg2.da(25), fg = "NONE", gui = "NONE" },
    VisualNOS { Visual },
    WarningMsg { bg = "NONE", fg = c.red, gui = "NONE" },
    DiffText { bg = "NONE", fg = "NONE", gui = "NONE" },
    DiffAdd { bg = c.sign_add, fg = "NONE", gui = "NONE" },
    DiffChange { bg = c.sign_change, fg = "NONE", gui = "NONE" },
    DiffDelete { bg = c.sign_delete, fg = "NONE", gui = "NONE" },
    QuickFixLine { CursorLine },
    PmenuSbar { bg = c.bg2.li(15), fg = "NONE", gui = "NONE" },
    PmenuThumb { bg = c.white, fg = "NONE", gui = "NONE" },
    MatchParen { CursorLine, fg = "NONE", gui = "NONE" },
    Cursor { fg = "NONE", bg = "NONE", gui = "reverse" },
    lCursor { Cursor },
    CursorIM { Cursor },
    TermCursor { Cursor },
    TermCursorNC { Cursor },
    Conceal { bg = "NONE", fg = c.blue, gui = "NONE" },
    Directory { bg = "NONE", fg = c.blue, gui = "NONE" },
    SpecialKey { bg = "NONE", fg = c.blue, gui = "bold" },
    Title { bg = "NONE", fg = c.blue, gui = "bold" },
    ErrorMsg { bg = "NONE", fg = c.error_red, gui = "NONE" },
    Search { bg = c.gray_blue, fg = c.white },
    IncSearch { Search },
    Substitute { Search },
    MoreMsg { bg = "NONE", fg = c.aqua, gui = "NONE" },
    Question { MoreMsg },
    EndOfBuffer { bg = "NONE", fg = c.bg, gui = "NONE" },
    NonText { EndOfBuffer },

    String { fg = c.green },
    Character { fg = c.light_green },
    Constant { fg = c.orange },
    Number { fg = c.red },
    Boolean { fg = c.red },
    Float { fg = c.red },

    Identifier { fg = c.white },
    Function { fg = c.yellow },
    Operator { fg = c.gray_blue },

    Type { fg = c.purple },
    StorageClass { Type },
    Structure { Type },
    Typedef { Type },

    Keyword { fg = c.blue },
    Statement { Keyword },
    Conditional { Keyword },
    Repeat { Keyword },
    Label { Keyword },
    Exception { Keyword },

    Include { Keyword },
    PreProc { fg = c.aqua },
    Define { PreProc },
    Macro { PreProc },
    PreCondit { PreProc },

    Special { fg = c.orange },
    SpecialChar { Character },
    Tag { fg = c.pale_purple },
    Debug { fg = c.red },
    Delimiter { fg = c.white.da(25) },
    SpecialComment { fg = c.gray },
    Underlined { fg = "NONE", gui = "underline" },
    Bold { fg = "NONE", gui = "bold" },
    Italic { fg = "NONE", gui = "italic" },

    -- Todo
    -- ("Ignore", below, may be invisible...)
    Ignore { fg = c.white },
    Todo { bg = "NONE", fg = c.red, gui = "bold" },
    Error { fg = c.error_red },

    -- Treesitter
    TSComment { Comment }, -- comment blocks.
    luaTSConstructor { bg = "NONE", fg = c.white.da(25) }, -- override Lua curly braces
    TSAnnotation { bg = "NONE", fg = c.aqua }, -- For C++/Dart attributes, annotations that can be attached to the code to denote some kind of meta information.
    TSAttribute { bg = "NONE", fg = c.aqua }, -- (unstable) TODO: docs
    TSConstructor { Type }, -- For constructor calls and definitions: `{ }` in Lua, and Java constructors.
    TSType { Type }, -- types.
    TSTypeBuiltin { Type }, -- builtin types.
    TSConditional { Conditional }, -- keywords related to conditionnals.
    TSException { Exception }, -- exception related keywords.
    TSInclude { Include }, -- includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.
    TSKeyword { Keyword }, -- keywords that don't fall in previous categories.
    TSKeywordFunction { Keyword }, -- keywords used to define a fuction.
    TSLabel { Label }, -- labels: `label:` in C and `:label:` in Lua.
    TSNamespace { bg = "NONE", fg = c.blue }, -- For identifiers referring to modules and namespaces.
    TSRepeat { Repeat }, -- keywords related to loops.
    TSConstant { Constant }, -- constants
    TSConstBuiltin { Constant }, -- constant that are built in the language: `nil` in Lua.
    TSFloat { Float }, -- floats.
    TSNumber { Number }, -- all numbers
    TSBoolean { Boolean }, -- booleans.
    TSCharacter { Character }, -- characters.
    TSError { bg = "NONE", fg = "NONE" }, -- For syntax/parser errors.
    TSFunction { Function }, -- function (calls and definitions).
    TSFuncBuiltin { Function }, -- builtin functions: `table.insert` in Lua.
    TSMethod { Function }, -- method calls and definitions.
    TSConstMacro { Macro }, -- constants that are defined by macros: `NULL` in C.
    TSFuncMacro { Macro }, -- macro defined fuctions (calls and definitions): each `macro_rules` in Rust.
    TSVariableBuiltin { bg = "NONE", fg = c.aqua }, -- Variable names that are defined by the languages, like `this` or `self`.
    TSProperty { fg = c.aqua },
    TSOperator { Operator }, -- any operator: `+`, but also `->` and `*` in C.
    TSVariable { bg = "NONE", fg = c.white }, -- Any variable name that does not have another highlight.
    TSField { bg = "NONE", fg = c.white }, -- For fields.
    TSParameter { TSField }, -- parameters of a function.
    TSParameterReference { TSParameter }, -- references to parameters of a function.
    TSSymbol { Identifier }, -- identifiers referring to symbols or atoms.
    TSText { fg = c.white }, -- strings considered text in a markup language.
    TSPunctDelimiter { Delimiter }, -- delimiters ie: `.`
    TSTagDelimiter { Delimiter }, -- Tag delimiter like `<` `>` `/`
    TSPunctBracket { Delimiter }, -- brackets and parens.
    TSPunctSpecial { Delimiter }, -- special punctutation that does not fall in the catagories before.
    TSString { String }, -- strings.
    TSStringRegex { TSString }, -- regexes.
    TSStringEscape { Character }, -- escape characters within a string.
    TSWarning { Todo }, -- Variable names that are defined by the languages, like `this` or `self`.
    TSTag { Tag }, -- Tags like html tag names.
    TSEmphasis { gui = "italic" }, -- text to be represented with emphasis.
    TSUnderline { gui = "underline" }, -- text to be represented with an underline.
    TSStrike { gui = "strikethrough" }, -- strikethrough text.
    TSTitle { Title }, -- Text that is part of a title.
    TSLiteral { String }, -- Literal text.
    TSURI { fg = c.aqua }, -- Any URI like a link or email.
    -- TSNone                { },    -- TODO: docs

    -- These groups are for the native LSP client. Some other LSP clients may
    -- use these groups, or use their own. Consult your LSP client's
    -- documentation.

    LspDiagnosticsDefaultError { bg = "NONE", fg = c.error_red, gui = "NONE" },
    LspDiagnosticsDefaultWarning { bg = "NONE", fg = c.warning_orange, gui = "NONE" },
    LspDiagnosticsDefaultInformation { bg = "NONE", fg = c.info_yellow, gui = "NONE" },
    LspDiagnosticsDefaultHint { bg = "NONE", fg = c.hint_blue, gui = "NONE" },

    LspDiagnosticsVirtualTextError { LspDiagnosticsDefaultError },
    LspDiagnosticsVirtualTextWarning { LspDiagnosticsDefaultWarning },
    LspDiagnosticsVirtualTextInformation { LspDiagnosticsDefaultInformation },
    LspDiagnosticsVirtualTextHint { LspDiagnosticsDefaultHint },

    LspDiagnosticsFloatingError { fg = c.error_red, gui = "NONE" },
    LspDiagnosticsFloatingWarning { fg = c.warning_orange, gui = "NONE" },
    LspDiagnosticsFloatingInformation { fg = c.info_yellow, gui = "NONE" },
    LspDiagnosticsFloatingHint { fg = c.hint_blue, gui = "NONE" },

    LspDiagnosticsSignError { fg = c.error_red, gui = "NONE" },
    LspDiagnosticsSignWarning { fg = c.warning_orange, gui = "NONE" },
    LspDiagnosticsSignInformation { fg = c.info_yellow, gui = "NONE" },
    LspDiagnosticsSignHint { fg = c.hint_blue, gui = "NONE" }, -- Tree-Sitter

    LspDiagnosticsError { LspDiagnosticsSignError },
    LspDiagnosticsWarning { LspDiagnosticsSignWarning },
    LspDiagnosticsInformation { LspDiagnosticsSignInformation },
    LspDiagnosticsHint { LspDiagnosticsSignHint },

    -- LspReferenceText {bg = c.bg1, fg = "NONE", gui = "underline"},
    -- LspReferenceRead {bg = c.bg1, fg = "NONE", gui = "underline"},
    -- LspReferenceWrite {bg = c.bg1, fg = "NONE", gui = "underline"},

    LspDiagnosticsUnderlineError { fg = "NONE", gui = "underline", sp = c.red },
    LspDiagnosticsUnderlineWarning { fg = "NONE", gui = "underline", sp = c.yellow },
    LspDiagnosticsUnderlineInformation { fg = "NONE", gui = "underline", sp = c.blue },
    LspDiagnosticsUnderlineHint { fg = "NONE", gui = "underline", sp = c.green },

    -- gitsigns.nvim
    SignAdd { fg = c.sign_add },
    SignChange { fg = c.sign_change },
    SignDelete { fg = c.sign_delete }, -- Any URI like a link or email.
    GitSignsAdd { fg = c.sign_add },
    GitSignsChange { fg = c.sign_change },
    GitSignsDelete { fg = c.sign_delete },

    -- telescope.nvim
    TelescopeSelection { bg = "NONE", fg = c.aqua },
    TelescopeMatching { bg = "NONE", fg = c.red, gui = "bold" },
    TelescopeBorder { bg = c.bg1, fg = c.gray }, -- nvim-tree.lua

    -- Nvimtree
    NvimTreeFolderIcon { fg = c.blue },
    NvimTreeIndentMarker { fg = c.gray },
    NvimTreeNormal { fg = c.white.da(10), bg = c.bg1 },
    NvimTreeFolderName { fg = c.blue },
    NvimTreeOpenedFolderName { fg = c.aqua.da(10), gui = "italic" },
    NvimTreeOpenedFile { NvimTreeOpenedFolderName },
    NvimTreeRootFolder { fg = c.blue.da(20) },
    NvimTreeExecFile { fg = c.green },
    NvimTreeImageFile { fg = c.purple },
    NvimTreeSpecialFile { fg = c.aqua },

    NvimTreeGitStaged { fg = c.sign_add },
    NvimTreeGitNew { fg = c.sign_add },
    NvimTreeGitDirty { fg = c.sign_add },
    NvimTreeGitRenamed { fg = c.sign_change },
    NvimTreeGitMerge { fg = c.sign_change },
    NvimTreeGitDelete { fg = c.sign_delete },
    NvimTreeVertSplit { fg = c.bg1, bg = c.bg1 },

    -- BarBar
    TabLine { bg = c.bg1, fg = c.white, gui = "NONE" },
    TabLineFill { bg = c.bg1, fg = c.white, gui = "NONE" },
    TabLineSel { bg = c.blue, fg = c.bg1, gui = "NONE" },

    BufferCurrent { fg = c.fg, bg = c.bg },
    BufferCurrentIndex { fg = c.aqua, bg = c.bg },
    BufferCurrentMod { fg = c.info_yellow, bg = c.bg },
    BufferCurrentSign { fg = c.aqua, bg = c.bg },
    BufferCurrentTarget { fg = c.red, bg = c.bg, gui = "bold" },

    BufferVisible { fg = c.fg, bg = c.bg },
    BufferVisibleIndex { fg = c.fg, bg = c.bg },
    BufferVisibleMod { fg = c.info_yellow, bg = c.bg },
    BufferVisibleSign { fg = c.info_yellow, bg = c.bg },
    BufferVisibleTarget { fg = c.red, bg = c.bg, gui = "bold" },

    BufferInactive { fg = c.gray, bg = c.bg1 },
    BufferInactiveIndex { fg = c.gray, bg = c.bg1 },
    BufferInactiveMod { fg = c.info_yellow, bg = c.bg1 },
    BufferInactiveSign { fg = c.gray, bg = c.bg1 },
    BufferInactiveTarget { fg = c.red, bg = c.bg1 },

    -- some fix for html related stuff
    htmlH1 { Title }, -- markdown stuff
    mkdLink { fg = c.aqua, gui = "underline" },
    mkdLineBreak { bg = "NONE", fg = "NONE", gui = "NONE" },
    mkdHeading { fg = c.white },
    mkdInlineURL { mkdLink },
    mkdUnderline { fg = c.gray },
    markdownUrl { mkdLink },
    markdownCode { fg = c.orange, bg = "NONE" },
    markdownLinkTextDelimiter { Delimiter },
    markdownLinkDelimiter { Delimiter },
    markdownIdDelimiter { Delimiter },
    markdownLinkText { fg = c.aqua },
    markdownItalic { fg = "NONE", gui = "italic" }, -- flutter-tools.nvim
    FlutterWidgetGuides { fg = c.gray.li(10) }, -- statusline

    StatusLine { bg = c.bg1, fg = c.white }, -- status line of current window
    StatusLineNC { bg = c.bg1, fg = c.light_gray }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    StatusLineSeparator { bg = c.bg1, fg = "NONE" },
    StatusLineGit { bg = c.bg1, fg = c.orange },
    StatusLineGitAdd { bg = c.bg1, fg = c.green },
    StatusLineGitChange { bg = c.bg1, fg = c.blue },
    StatusLineGitDelete { bg = c.bg1, fg = c.red },
    StatusLineLspDiagnosticsError { bg = c.bg1, fg = c.error_red, gui = "NONE" },
    StatusLineLspDiagnosticsWarning { bg = c.bg1, fg = c.warning_orange, gui = "NONE" },
    StatusLineLspDiagnosticsInformation { bg = c.bg1, fg = c.info_yellow, gui = "NONE" },
    StatusLineLspDiagnosticsHint { bg = c.bg1, fg = c.hint_blue, gui = "NONE" },
    StatusLineTreeSitter { bg = c.bg1, fg = c.green },

    -- StatusLineMode {bg = c.gray, fg = c.bg, gui = "bold"},
    -- StatusLineDeco {bg = c.bg2, fg = c.yellow},
    -- StatusLineLCol {bg = c.bg2, fg = c.white},
    -- StatusLineLColAlt {bg = c.bg1, fg = c.white},
    -- StatusLineFT {bg = c.bg2, fg = c.white},
    -- StatusLineFTAlt {bg = c.bg2, fg = c.white},
    -- StatusLineGitAlt {bg = c.gray, fg = c.bg},
    -- StatusLineLSP {bg = c.bg1, fg = c.gray.li(25)},
    -- StatusLineFileName {bg = c.bg1, fg = c.white, gui = "bold"},

    -- lsp-trouble.nvim
    LspTroubleIndent { fg = c.gray.li(10) }, -- tabline stuff

    -- tabline diagnostic
    TabLineError { LspDiagnosticsSignError },
    TabLineWarning { LspDiagnosticsSignWarning },
    TabLineHint { LspDiagnosticsSignHint },
    TabLineInformation { LspDiagnosticsSignInformation }, -- which-key.nvim

    WhichKey { fg = c.purple }, -- nvim-compe
    WhichKeySeperator { fg = c.green }, -- nvim-compe
    WhichKeyGroup { fg = c.blue }, -- nvim-compe
    WhichKeyDesc { fg = c.aqua }, -- nvim-compe
    WhichKeyFloat { bg = c.bg1 }, -- nvim-compe

    CompeDocumentation { Pmenu, fg = "NONE" }, -- diffview

    DiffviewNormal { NvimTreeNormal },
    DiffviewStatusAdded { SignAdd },
    DiffviewStatusModified { SignChange },
    DiffviewStatusRenamed { SignChange },
    DiffviewStatusDeleted { SignDelete },
    DiffviewFilePanelInsertion { SignAdd },
    DiffviewFilePanelDeletion { SignDelete },
    DiffviewVertSplit { fg = c.gray, bg = c.bg },

    DashboardHeader { fg = c.blue },
    DashboardCenter { fg = c.purple },
    DashboardFooter { fg = c.aqua },

    IndentBlanklineContextChar { fg = c.gray.da(20) },

    CodiVirtualText { fg = c.hint_blue },
  }
end)

-- return our parsed theme for extension or use else where.
return theme

-- vi:nowrap

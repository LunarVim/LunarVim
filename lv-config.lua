--[[
O is the global options object

Formatters and linters should be
filled in as strings with either
a global executable or a path to
an executable
]] -- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
-- general
O.auto_complete = true
O.colorscheme = 'lunar'
-- TODO is there a lua native way to do this?
vim.cmd('colorscheme ' .. O.colorscheme)
O.auto_close_tree = 0
O.wrap_lines = false
O.timeoutlen = 100
O.document_highlight = true
O.extras = false
O.leader_key = ' '
O.ignore_case = true
O.smart_case = true

-- After changing plugin config it is recommended to run :PackerCompile
O.plugin.hop.active = false
O.plugin.dial.active = false
O.plugin.dashboard.active = true
O.plugin.matchup.active = false
O.plugin.colorizer.active = false
O.plugin.numb.active = false
O.plugin.ts_playground.active = false
O.plugin.indent_line.active = false
O.plugin.gitlinker.active = false
O.plugin.zen.active = false

-- dashboard
-- O.dashboard.custom_header = {""}
-- O.dashboard.footer = {""}

-- if you don't want all the parsers change this to a table of the ones you want
O.treesitter.ensure_installed = "all"
O.treesitter.ignore_install = {"haskell"}
O.treesitter.highlight.enabled = true

O.lang.clang.diagnostics.virtual_text = false
O.lang.clang.diagnostics.signs = false
O.lang.clang.diagnostics.underline = false

-- python
-- add things like O.python.formatter.yapf.exec_path
-- add things like O.python.linter.flake8.exec_path
-- add things like O.python.formatter.isort.exec_path
O.lang.python.formatter = 'yapf'
-- O.python.linter = 'flake8'
O.lang.python.active = true
O.lang.python.isort = true
O.lang.python.autoformat = true
O.lang.python.diagnostics.virtual_text = true
O.lang.python.diagnostics.signs = true
O.lang.python.diagnostics.underline = true
O.lang.python.analysis.type_checking = "off"
O.lang.python.analysis.auto_search_paths = true
O.lang.python.analysis.use_library_code_types = true

-- lua
-- TODO look into stylua
O.lang.lua.active = true
O.lang.lua.formatter = 'lua-format'
-- O.lua.formatter = 'lua-format'
O.lang.lua.autoformat = false

-- javascript
O.lang.tsserver.formatter = 'prettier'
O.lang.tsserver.linter = nil
O.lang.tsserver.autoformat = true

-- json
O.lang.json.active = false
O.lang.json.autoformat = true

-- ruby
O.lang.ruby.autoformat = true

-- go
O.lang.go.autoformat = true

-- rust
O.lang.rust.autoformat = true
-- create custom autocommand field (This would be easy with lua)

-- Turn off relative_numbers
-- O.relative_number = false

-- Turn off cursorline
-- O.cursorline = false

-- Neovim turns the default cursor to 'Block'
-- when switched back into terminal.
-- This below line fixes that. Uncomment if needed.

-- vim.cmd('autocmd VimLeave,VimSuspend * set guicursor=a:ver90') -- Beam
-- vim.cmd('autocmd VimLeave,VimSuspend * set guicursor=a:hor20') -- Underline

-- NOTE: Above code doesn't take a value from the terminal's cursor and
--       replace it. It hardcodes the cursor shape.
--       And I think `ver` means vertical and `hor` means horizontal.
--       The numbers didn't make a difference in alacritty. Please change
--       the number to something that suits your needs if it looks weird.

-- TODO
-- custom autocommands
-- user defined plugin config
-- custom settings


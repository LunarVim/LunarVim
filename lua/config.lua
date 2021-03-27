--[[
O is the global options object

Formatters and linters should be
filled in as strings with either
a global executable or a path to
an executable
]]


O.auto_complete = true
O.colorscheme = 'nvcode'

O.python.formatter = 'yapf'
O.python.linter = nil
O.python.autoformat = false
O.python.diagnostics.virtual_text = false
O.python.diagnostics.signs = false
O.python.diagnostics.underline = false



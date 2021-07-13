--[[
O is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]

-- These are example configurations. More examples on the [wiki](https://github.com/ChristianChiarulli/LunarVim/wiki)
-- Use the autocompletion to explore the options
O.leader_key = ' '
O.colorscheme = 'spacegray'
O.transparent_window = false
O.completion.autocomplete = true
O.default_options.timeoutlen = 100
O.default_options.relativenumber = true
O.default_options.wrap = true
O.format_on_save = true
O.auto_close_tree = 0
O.ignore_case = true
O.smart_case = true
O.plugin.indent_line.active = false
O.cursorline = false

O.plugin.dashboard.active = true
O.plugin.floatterm.active = true
O.plugin.zen.active = false
O.plugin.zen.window.height = 0.90

-- TODO: User config for predefined plugins from wiki.  
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile

-- if you don't want all the parsers change this to a table of the ones you want
O.treesitter.ensure_installed = "maintained"
O.treesitter.ignore_install = { "haskell" }
O.treesitter.highlight.enabled = true

-- python
-- O.lang.python.linter = 'flake8'
O.lang.python.isort = true
O.lang.python.diagnostics.virtual_text = true
O.lang.python.analysis.use_library_code_types = true
-- to change default formatter from yapf to black
-- O.lang.python.formatter.exe = "black"
-- O.lang.python.formatter.args = {"-"}

-- go
-- to change default formatter from gofmt to goimports
-- O.lang.formatter.go.exe = "goimports"

-- javascript
O.lang.tsserver.linter = nil

-- rust
-- O.lang.rust.formatter = {
--   exe = "rustfmt",
--   args = {"--emit=stdout", "--edition=2018"},
-- }

-- latex
-- O.lang.latex.auto_save = false
-- O.lang.latex.ignore_errors = { }

-- Additional Plugins
-- O.user_plugins = {
--     {"folke/tokyonight.nvim"}, {
--         "ray-x/lsp_signature.nvim",
--         config = function() require"lsp_signature".on_attach() end,
--         event = "InsertEnter"
--     }
-- }

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- O.user_autocommands = {{ "BufWinEnter", "*", "echo \"hi again\""}}

-- Additional Leader bindings for WhichKey
-- O.user_which_key = {
--   A = {
--     name = "+Custom Leader Keys",
--     a = { "<cmd>echo 'first custom command'<cr>", "Description for a" },
--     b = { "<cmd>echo 'second custom command'<cr>", "Description for b" },
--   },
-- }

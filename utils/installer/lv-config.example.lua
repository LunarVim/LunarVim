--[[
O is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]] -- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
-- general
O.auto_close_tree = 0
O.auto_complete = true
O.colorscheme = "spacegray"
O.document_highlight = true
O.format_on_save = true
O.ignore_case = true
O.leader_key = " "
O.lushmode = false
O.smart_case = true
O.timeoutlen = 100
O.transparent_window = false
O.wrap_lines = false

-- TODO User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
O.plugin.colorizer.active = false
O.plugin.dashboard.active = true
O.plugin.indent_line.active = false
O.plugin.ts_playground.active = false
O.plugin.zen.active = false

-- dashboard
-- O.dashboard.custom_header = {""}
-- O.dashboard.footer = {""}

O.lang.clang.diagnostics.signs = true
O.lang.clang.diagnostics.underline = true
O.lang.clang.diagnostics.virtual_text = true

-- if you don't want all the parsers change this to a table of the ones you want
O.treesitter.ensure_installed = "all"
O.treesitter.highlight.enabled = true
O.treesitter.ignore_install = {"haskell"}


-- python
O.lang.python.analysis.auto_search_paths = true
O.lang.python.analysis.type_checking = "off"
O.lang.python.analysis.use_library_code_types = true
O.lang.python.diagnostics.signs = true
O.lang.python.diagnostics.underline = true
O.lang.python.diagnostics.virtual_text = true
O.lang.python.isort = true
-- add things like O.python.linter.flake8.exec_path
-- O.python.linter = 'flake8'

-- javascript
O.lang.tsserver.linter = nil

-- php
O.lang.php.diagnostics.signs = true
O.lang.php.diagnostics.underline = true
O.lang.php.environment.php_version = "7.4"
O.lang.php.filetypes = {"php", "phtml"}
O.lang.php.format = {
  format = {
    default = "psr12"
  }
}


-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- O.user_autocommands = {{ "BufWinEnter", "*", "echo \"hi again\""}}

-- Additional Plugins
-- O.custom_plugins = {{"windwp/nvim-ts-autotag"}}


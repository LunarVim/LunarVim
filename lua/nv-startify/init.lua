vim.g.startify_custom_header = {
    '   ███╗   ██╗██╗   ██╗ ██████╗ ██████╗ ██████╗ ███████╗',
    '   ████╗  ██║██║   ██║██╔════╝██╔═══██╗██╔══██╗██╔════╝',
    '   ██╔██╗ ██║██║   ██║██║     ██║   ██║██║  ██║█████╗',
    '   ██║╚██╗██║╚██╗ ██╔╝██║     ██║   ██║██║  ██║██╔══╝',
    '   ██║ ╚████║ ╚████╔╝ ╚██████╗╚██████╔╝██████╔╝███████╗',
    '   ╚═╝  ╚═══╝  ╚═══╝   ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝'
}

vim.g.webdevicons_enable_startify = 1
vim.g.startify_enable_special = 0
vim.g.startify_session_dir = '~/AppData/Local/nvim/session'
vim.g.startify_session_autoload = 1
vim.g.startify_session_delete_buffers = 1
vim.g.startify_change_to_vcs_root = 1
vim.g.startify_fortune_use_unicode = 1
vim.g.startify_session_persistence = 1
vim.g.startify_session_dir = '~/AppData/Local/nvim/session'

vim.api.nvim_exec(
    'let startify_lists = [ { \'type\': \'files\',     \'header\': [\'   Files\'] }, { \'type\': \'sessions\',  \'header\': [\'   Sessions\'] },    { \'type\': \'bookmarks\', \'header\': [\'   Bookmarks\'] },                                                                   ]',
    true)

vim.api.nvim_exec(
    'let startify_bookmarks = [ { \'b\': \'~/Blog\' }, { \'c\': \'~/AppData/Local/nvim/lua/config.lua\' }, { \'z\': \'~/.zshrc\' }, { \'r\': \'~/AppData/Local/nvim/README.md\' }]',
    true)

vim.cmd([[
function! StartifyEntryFormat()
        return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
endfunction
]])


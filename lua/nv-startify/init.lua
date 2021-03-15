vim.g.startify_custom_header = {
        '        _   ___    ________          __   ',
        '       / | / / |  / / ____/___  ____/ /__ ',
        '      /  |/ /| | / / /   / __ \\/ __  / _ \\',
        '     / /|  / | |/ / /___/ /_/ / /_/ /  __/',
        '    /_/ |_/  |___/\\____/\\____/\\__,_/\\___/ ',
        }

vim.g.webdevicons_enable_startify = 1
vim.g.startify_enable_special = 0
vim.g.startify_session_dir = '~/.config/nvim/session'
vim.g.startify_session_autoload = 1
vim.g.startify_session_delete_buffers = 1
vim.g.startify_change_to_vcs_root = 1
vim.g.startify_fortune_use_unicode = 1
vim.g.startify_session_persistence = 1
vim.g.startify_session_dir = '~/.config/nvim/session'


vim.api.nvim_exec('let startify_lists = [ { \'type\': \'files\',     \'header\': [\'   Files\'] }, { \'type\': \'sessions\',  \'header\': [\'   Sessions\'] },    { \'type\': \'bookmarks\', \'header\': [\'   Bookmarks\'] },                                                                   ]',true)

vim.api.nvim_exec('let startify_bookmarks = [ { \'b\': \'~/Blog\' }, { \'i\': \'~/.config/nvim/init.vim\' }, { \'z\': \'~/.zshrc\' }]', true)

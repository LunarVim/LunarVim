-- vim.g.dashboard_custom_header = {
--     '███╗   ██╗██╗   ██╗ ██████╗ ██████╗ ██████╗ ███████╗',
--     '████╗  ██║██║   ██║██╔════╝██╔═══██╗██╔══██╗██╔════╝',
--     '██╔██╗ ██║██║   ██║██║     ██║   ██║██║  ██║█████╗',
--     '██║╚██╗██║╚██╗ ██╔╝██║     ██║   ██║██║  ██║██╔══╝',
--     '██║ ╚████║ ╚████╔╝ ╚██████╗╚██████╔╝██████╔╝███████╗',
--     '╚═╝  ╚═══╝  ╚═══╝   ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝'
-- }
-- vim.g.dashboard_custom_header = {
--
-- '      _..._                                                                           ',
-- '    .\'     `.   ██      ██    ██ ███    ██  █████  ██████  ██    ██ ██ ███    ███ ',
-- '   :         :  ██      ██    ██ ████   ██ ██   ██ ██   ██ ██    ██ ██ ████  ████ ',
-- '   :         :  ██      ██    ██ ██ ██  ██ ███████ ██████  ██    ██ ██ ██ ████ ██ ',
-- '   `.       .\'  ██      ██    ██ ██  ██ ██ ██   ██ ██   ██  ██  ██  ██ ██  ██  ██ ',
-- '     `-...-\'    ███████  ██████  ██   ████ ██   ██ ██   ██   ████   ██ ██      ██ ',
--
-- }
--[[
vim.g.dashboard_custom_header = {

'                 _..._                                                                           ',
'               .\'   (_`.    _                         __     ___           ',
'              :  .      :  | |   _   _ _ __   __ _ _ _\\ \\   / (_)_ __ ___  ',
'              :)    ()  :  | |  | | | | \'_ \\ / _` | \'__\\ \\ / /| | \'_ ` _ \\ ',
'              `.   .   .\'  | |__| |_| | | | | (_| | |   \\ V / | | | | | | |',
'                `-...-\'    |_____\\__,_|_| |_|\\__,_|_|    \\_/  |_|_| |_| |_|',

}
--]]
vim.g.dashboard_custom_header = {

"          |             ",
"     \\    |    /        ",
" `.   \\   |   /   .\'    ",
"   `.  \\  |  /  .\'      ",
"`-.  `. \\d8b/ .\'  .-\'    ____        _          __     ___           ",
"   `-. do0o88b .-\'      / ___|  ___ | | __ _ _ _\\ \\   / (_)_ __ ___  ",
"<~~~~ 8o0O0o888 ~~~~>   \\___ \\ / _ \\| |/ _` | '__\\ \\ / /| | '_ ` _ \\ ",
"<~~~~ 8o00o8888 ~~~~>    ___) | (_) | | (_| | |   \\ V / | | | | | | |",
"   _-\' qoo888p \'-_      |____/ \\___/|_|\\__,_|_|    \\_/  |_|_| |_| |_|",
",-\'  ,\' /q8p\\ `.  `-.   ",
"   ,\'  /  |  \\  `.      ",
" ,\'   /   |   \\   `.    ",
"     /    |    \\        ",
"          |             ",

}

vim.g.dashboard_default_executive = 'telescope'

vim.g.dashboard_custom_section = {
    a = {description = {'  Find File          '}, command = 'Telescope find_files'},
    b = {description = {'  Recently Used Files'}, command = 'Telescope oldfiles'},
    c = {description = {'  Load Last Session  '}, command = 'SessionLoad'},
    d = {description = {'  Find Word          '}, command = 'Telescope live_grep'},
    e = {description = {'  Edit Colourscheme  '}, command = 'Telescope colorscheme'},
    f = {description = {'  Settings           '}, command = ':e ~/AppData/Local/nvim/lv-settings.lua'}
    -- e = {description = {'  Marks              '}, command = 'Telescope marks'}
}

-- file_browser = {description = {' File Browser'}, command = 'Telescope find_files'},

-- vim.g.dashboard_custom_shortcut = {
--     a = 'f',
--     find_word = 'SPC f a',
--     last_session = 'SPC s l',
--     new_file = 'SPC c n',
--     book_marks = 'SPC f b'
-- }
-- find_history = 'SPC f h',

-- vim.g.dashboard_session_directory = '~/.cache/nvim/session'
vim.g.dashboard_custom_footer = {'chrisatmachine.com & irishgreencitrus'}

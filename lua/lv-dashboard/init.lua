local M = {}

M.config = function()
    vim.g.dashboard_disable_at_vimenter = 0

    vim.g.dashboard_custom_header = O.dashboard.custom_header

    vim.g.dashboard_default_executive = 'telescope'

    vim.g.dashboard_custom_section = {
        a = {
            description = {'  Find File          '},
            command = 'Telescope find_files'
        },
        b = {
            description = {'  Recently Used Files'},
            command = 'Telescope oldfiles'
        },
        c = {
            description = {'  Load Last Session  '},
            command = 'SessionLoad'
        },
        d = {
            description = {'  Find Word          '},
            command = 'Telescope live_grep'
        },
        e = {
            description = {'  Settings           '},
            command = ':e ' .. CONFIG_PATH .. '/lv-config.lua'
        },
        f = {
            description = {'  Neovim Config Files'},
            command = 'lua require(\'telescope.builtin\').find_files({search_dirs = {"~/.config/nvim"}})'
        }
        -- e = {description = {'  Marks              '}, command = 'Telescope marks'}
    }

    -- file_browser = {description = {' File Browser'}, command = 'Telescope find_files'},


    -- vim.g.dashboard_session_directory = CACHE_PATH..'/session'
    vim.g.dashboard_custom_footer = O.dashboard.footer
end

require('lv-utils').define_augroups({
    _dashboard = {
        -- seems to be nobuflisted that makes my stuff disapear will do more testing
        {
            'FileType', 'dashboard',
            'setlocal nocursorline noswapfile synmaxcol& signcolumn=no norelativenumber nocursorcolumn nospell  nolist  nonumber bufhidden=wipe colorcolumn= foldcolumn=0 matchpairs= '
        }, {
            'FileType', 'dashboard',
            'set showtabline=0 | autocmd BufLeave <buffer> set showtabline=2'
        }, {'FileType', 'dashboard', 'nnoremap <silent> <buffer> q :q<CR>'}
    }
})

return M

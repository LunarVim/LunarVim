vim.api.nvim_set_keymap('n', '<TAB>', ':BufferNext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-TAB>', ':BufferPrevious<CR>', { noremap = true, silent = true })
--[[ nnoremap <silent>    <A-,> :BufferPrevious<CR>
nnoremap <silent>    <A-.> :BufferNext<CR> ]]


--" These commands will sort buffers by directory, language, or a custom criteria
--nnoremap <silent>be :BufferLineSortByExtension<CR>
--nnoremap <silent>bd :BufferLineSortByDirectory<CR>
--nnoremap <silent><mymap> :lua require'bufferline'.sort_buffers_by(function (buf_a, buf_b) return buf_a.id < buf_b.id end)<CR>
-- colors for active , inactive buffer tabs 
--[[ require "bufferline".setup {
    options = {
        -- buffer_close_icon = "",
        -- modified_icon = "●",
        -- close_icon = "",
        -- left_trunc_marker = "",
        -- right_trunc_marker = "",
        -- max_name_length = 14,
        -- max_prefix_length = 13,
        -- tab_size = 18,
        -- enforce_regular_tabs = true,
        -- view = "multiwindow",
        -- show_buffer_close_icons = true,
        -- separator_style = 'slant'
        separator_style = "thin"
    },
    highlights = {
        background = {
            guifg = "#abb2bf",
            guibg = "#282c34"
        },

        fill = {
            guifg = "#282c34",
            guibg = "#1e1e1e"
        },
        buffer_selected = {
            guifg = "#abb2bf",
            guibg = "#3A3E44",
            gui = "bold"
        },
        buffer_selected = {
            guifg = "#abb2bf",
            guibg = "#3A3E44",
            gui = "bold"
        },
        separator_visible = {
            guifg = "#1e1e1e",
            guibg = "#1e1e1e"
        },
        separator_selected = {
            guifg = "#1e1e1e",
            guibg = "#1e1e1e"
        },
        separator = {
            guifg = "#1e1e1e",
            guibg = "#1e1e1e"
        },
        indicator_selected = {
            guifg = "#abb2bf",
            guibg = "#3a3e44"
        },
        modified_selected = {
            guifg = "#abb2bf",
            guibg = "#3a3e44"
        },
        modified = {
            guifg = "#abb2bf",
            guibg = "#282c34"
        },
        modified_visible = {
            guifg = "#abb2bf",
            guibg = "#282c34"
        },
        duplicate_selected = {
            guifg = "#abb3bf",
            guibg = "#3a3e44",
            -- gui = "italic"
        },
        duplicate_visible = {
            guifg = "#abb3bf",
            guibg = "#282c34",
            -- gui = "italic"
        },
        duplicate = {
            guifg = "#abb3bf",
            guibg = "#282c34",
            -- gui = "italic"
        },
        tab = {
            guifg = "#abb3bf",
            guibg = "#282c34",
        },
        tab_selected = {
            guifg = "#abb3bf",
            guibg = "#282c34",
        },
        tab_close = {
            guifg = "#abb3bf",
            guibg = "#282c34",
        },
        pick_selected = {
            guifg = "#abb3bf",
            guibg = "#282c34",
            gui = "bold,italic"
        },
        pick_visible = {
            guifg = "#abb3bf",
            guibg = "#282c34",
            gui = "bold,italic"
        },
        pick = {
            guifg = "#abb3bf",
            guibg = "#282c34",
            gui = "bold,italic"
        }
    }
} ]]

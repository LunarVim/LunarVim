local M = {}

M.config = function()

    -- Buffer line setup
    require'bufferline'.setup {
        options = {
            indicator_icon = '▎',
            buffer_close_icon = '',
            modified_icon = '●',
            close_icon = '',
            close_command = "Bdelete %d",
            right_mouse_command = "Bdelete! %d",
            left_trunc_marker = '',
            right_trunc_marker = '',
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "EXPLORER",
                    text_align = "center",
                    padding = 1
                }
            },
            show_tab_indicators = true,
            show_close_icon = false
        },
        highlights = {
            fill = {
                guifg = {attribute = "fg", highlight = "Normal"},
                guibg = {attribute = "bg", highlight = "StatusLineNC"}
            },
            -- background = {
            --     guifg = {attribute = "fg", highlight = "Normal"},
            --     guibg = {attribute = "bg", highlight = "StatusLine"}
            -- },
            -- buffer_visible = {
            --     gui = "",
            --     guifg = {attribute = "fg", highlight = "Normal"},
            --     guibg = {attribute = "bg", highlight = "Normal"}
            -- },
            -- buffer_selected = {
            --     gui = "",
            --     guifg = {attribute = "fg", highlight = "Normal"},
            --     guibg = {attribute = "bg", highlight = "Normal"}
            -- },
            -- separator = {
            --     guifg = {attribute = "bg", highlight = "Normal"},
            --     guibg = {attribute = "bg", highlight = "StatusLine"}
            -- },
            -- separator_selected = {
            --     guifg = {attribute = "fg", highlight = "Special"},
            --     guibg = {attribute = "bg", highlight = "Normal"}
            -- },
            -- separator_visible = {
            --     guifg = {attribute = "fg", highlight = "Normal"},
            --     guibg = {attribute = "bg", highlight = "StatusLineNC"}
            -- },
            -- close_button = {
            --     guifg = {attribute = "fg", highlight = "Normal"},
            --     guibg = {attribute = "bg", highlight = "StatusLine"}
            -- },
            -- close_button_selected = {
            --     guifg = {attribute = "fg", highlight = "normal"},
            --     guibg = {attribute = "bg", highlight = "normal"}
            -- },
            -- close_button_visible = {
            --     guifg = {attribute = "fg", highlight = "normal"},
            --     guibg = {attribute = "bg", highlight = "normal"}
            -- }

        }
    }

end

return M

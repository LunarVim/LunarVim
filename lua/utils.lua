local function define_augroups(definitions) -- {{{1
    -- Create autocommand groups based on the passed definitions
    --
    -- The key will be the name of the group, and each definition
    -- within the group should have:
    --    1. Trigger
    --    2. Pattern
    --    3. Text
    -- just like how they would normally be defined from Vim itself
    for group_name, definition in pairs(definitions) do
        vim.cmd('augroup ' .. group_name)
        vim.cmd('autocmd!')

        for _, def in pairs(definition) do
            local command = table.concat(vim.tbl_flatten {'autocmd', def}, ' ')
            vim.cmd(command)
        end

        vim.cmd('augroup END')
    end
end

define_augroups(
    {_general_settings = {
            {'TextYankPost', '*', 'lua require(\'vim.highlight\').on_yank({higroup = \'IncSearch\', timeout = 200})'},
            {'BufWinEnter', '*', 'setlocal formatoptions-=c formatoptions-=r formatoptions-=o'},
            {'BufRead', '*', 'setlocal formatoptions-=c formatoptions-=r formatoptions-=o'},
            {'BufNewFile', '*', 'setlocal formatoptions-=c formatoptions-=r formatoptions-=o'},

            {'FileType', 'java', 'luafile ~/.config/nvim/lua/lsp/java-ls.lua'},
            {'FileType', 'java', 'nnoremap ca <Cmd>lua require(\'jdtls\').code_action()<CR>'},
            {'FileType', 'lua', 'lua print("hi")'},
            --{'BufRead', '*', 'lua vim.api.nvim_buf_set_option(0, "commentstring", "{/*%s*/}")'},
            --{'BufNewFile', '*', 'lua vim.api.nvim_buf_set_option(0, "commentstring", "{/*%s*/}")'},
            {'BufNewFile', '*', 'verbose setlocal commentstring="{/*%s*/}"'},
            {'BufRead', '*', 'verbose setlocal commentstring="{/*%s*/}"'},

        },
    }
)


-- Add this to lightbulb, java makes this annoying tho
-- autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()

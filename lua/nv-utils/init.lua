local function_wrapper = {}

function function_wrapper.define_augroups(definitions) -- {{{1
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
function_wrapper.define_augroups(
    {_general_settings = {
            {'TextYankPost', '*', 'lua require(\'vim.highlight\').on_yank({higroup = \'IncSearch\', timeout = 200})'},
            {'BufWinEnter', '*', 'setlocal formatoptions-=c formatoptions-=r formatoptions-=o'},
            {'BufRead', '*', 'setlocal formatoptions-=c formatoptions-=r formatoptions-=o'},
            {'BufNewFile', '*', 'setlocal formatoptions-=c formatoptions-=r formatoptions-=o'},
            {'FileType', 'java', 'luafile ~/.config/nvim/lua/lsp/java-ls.lua'},
            {'FileType', 'java', 'nnoremap ca <Cmd>lua require(\'jdtls\').code_action()<CR>'},

        },
    }
)


-- Add this to lightbulb, java makes this annoying tho
-- autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()

-- lsp

function function_wrapper.add_to_workspace_folder()
    vim.lsp.buf.add_workspace_folder()
end

function function_wrapper.clear_references()
    vim.lsp.buf.clear_references()
end

function function_wrapper.code_action()
    vim.lsp.buf.code_action()
end

function function_wrapper.declaration()
    vim.lsp.buf.declaration()
    vim.lsp.buf.clear_references()
end

function function_wrapper.definition()
    vim.lsp.buf.definition()
    vim.lsp.buf.clear_references()
end

function function_wrapper.document_highlight()
    vim.lsp.buf.document_highlight()
end

function function_wrapper.document_symbol()
    vim.lsp.buf.document_symbol()
end

function function_wrapper.formatting()
    vim.lsp.buf.formatting()
end

function function_wrapper.formatting_sync()
    vim.lsp.buf.formatting_sync()
end

function function_wrapper.hover()
    vim.lsp.buf.hover()
end

function function_wrapper.implementation()
    vim.lsp.buf.implementation()
end

function function_wrapper.incoming_calls()
    vim.lsp.buf.incoming_calls()
end

function function_wrapper.list_workspace_folders()
    vim.lsp.buf.list_workspace_folders()
end

function function_wrapper.outgoing_calls()
    vim.lsp.buf.outgoing_calls()
end

function function_wrapper.range_code_action()
    vim.lsp.buf.range_code_action()
end

function function_wrapper.range_formatting()
    vim.lsp.buf.range_formatting()
end

function function_wrapper.references()
    vim.lsp.buf.references()
    vim.lsp.buf.clear_references()
end

function function_wrapper.remove_workspace_folder()
    vim.lsp.buf.remove_workspace_folder()
end

function function_wrapper.rename()
    vim.lsp.buf.rename()
end

function function_wrapper.signature_help()
    vim.lsp.buf.signature_help()
end

function function_wrapper.type_definition()
    vim.lsp.buf.type_definition()
end

function function_wrapper.workspace_symbol()
    vim.lsp.buf.workspace_symbol()
end

-- diagnostic

function function_wrapper.get_all()
    vim.lsp.diagnostic.get_all()
end

function function_wrapper.get_next()
    vim.lsp.diagnostic.get_next()
end

function function_wrapper.get_prev()
    vim.lsp.diagnostic.get_prev()
end

function function_wrapper.goto_next()
    vim.lsp.diagnostic.goto_next()
end

function function_wrapper.goto_prev()
    vim.lsp.diagnostic.goto_prev()
end

function function_wrapper.show_line_diagnostics()
    vim.lsp.diagnostic.show_line_diagnostics()
end

-- git signs

function function_wrapper.next_hunk() 
    require('gitsigns').next_hunk()
end

function function_wrapper.prev_hunk()
    require('gitsigns').prev_hunk()
end

function function_wrapper.stage_hunk()
    require('gitsigns').stage_hunk()
end

function function_wrapper.undo_stage_hunk()
    require('gitsigns').undo_stage_hunk()
end

function function_wrapper.reset_hunk()
    require('gitsigns').reset_hunk()
end

function function_wrapper.reset_buffer()
    require('gitsigns').reset_buffer()
end

function function_wrapper.preview_hunk()
    require('gitsigns').preview_hunk()
end

function function_wrapper.blame_line()
    require('gitsigns').blame_line()
end


-- misc


-- autoformat
-- autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)

return function_wrapper


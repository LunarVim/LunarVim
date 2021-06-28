require("which-key").setup {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = false, -- adds help for operators like d, y, ...
            motions = false, -- adds help for motions
            text_objects = false, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true -- bindings for prefixed with g
        }
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+" -- symbol prepended to a group
    },
    window = {
        border = "single", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = {1, 0, 1, 0}, -- extra window margin [top, right, bottom, left]
        padding = {2, 2, 2, 2} -- extra window padding [top, right, bottom, left]
    },
    layout = {
        height = {min = 4, max = 25}, -- min and max height of the columns
        width = {min = 20, max = 50}, -- min and max width of the columns
        spacing = 3 -- spacing between columns
    },
    hidden = {"<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
    show_help = true -- show help message on the command line when the popup is visible
}

-- Set leader
if O.leader_key == ' ' or O.leader_key == 'space' then
    vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})
    vim.g.mapleader = ' '
else
    vim.api.nvim_set_keymap('n', O.leader_key, '<NOP>', {noremap = true, silent = true})
    vim.g.mapleader = O.leader_key
end

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false -- use `nowait` when creating keymaps
}

-- no hl
vim.api.nvim_set_keymap('n', '<Leader>h', ':let @/=""<CR>', {noremap = true, silent = true})

-- explorer
vim.api.nvim_set_keymap('n', '<Leader>e', ":NvimTreeToggle<CR>", {noremap = true, silent = true})

-- telescope
vim.api.nvim_set_keymap('n', '<Leader>f', ':Telescope find_files<CR>', {noremap = true, silent = true})

-- dashboard
vim.api.nvim_set_keymap('n', '<Leader>;', ':Dashboard<CR>', {noremap = true, silent = true})

-- Comments
vim.api.nvim_set_keymap("n", "<leader>/", ":CommentToggle<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("v", "<leader>/", ":CommentToggle<CR>", {noremap = true, silent = true})

-- close buffer
vim.api.nvim_set_keymap("n", "<leader>c", ":BufferClose<CR>", {noremap = true, silent = true})

-- open projects
vim.api.nvim_set_keymap('n', '<leader>p', ":lua require'telescope'.extensions.project.project{}<CR>",
                        {noremap = true, silent = true})

vim.api.nvim_set_keymap("n", "<leader>z", ":TZAtaraxis<CR>", {noremap = true, silent = true})
-- z = {"<cmd>TZAtaraxis<cr>", "toggle zen"}

-- TODO create entire treesitter section

local mappings = {

    ["/"] = "Comment",
    ["c"] = "Close Buffer",
    ["e"] = "Explorer",
    ["f"] = "Find File",
    ["h"] = "No Highlight",
    ["p"] = "Projects",
    ["z"] = "Zen",
    [";"] = "Dashboard",
    b = {
      name = "+Buffers",
      j = {"<cmd>BufferPick<cr>", "jump to buffer"},
      w = {"<cmd>BufferWipeout<cr>", "wipeout buffer"},
      e = {"<cmd>BufferCloseAllButCurrent<cr>", "close all but current buffer"},
      h = {"<cmd>BufferCloseBuffersLeft<cr>", "close all buffers to the left"},
      l = {"<cmd>BufferCloseBuffersRight<cr>", "close all BufferLines to the right"},
      D = {"<cmd>BufferOrderByDirectory<cr>", "sort BufferLines automatically by directory"},
      L = {"<cmd>BufferOrderByLanguage<cr>", "sort BufferLines automatically by language"},
    },


    d = {
        name = "Diagnostics",
        t = {"<cmd>TroubleToggle<cr>", "trouble"},
        w = {"<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", "workspace"},
        d = {"<cmd>TroubleToggle lsp_document_diagnostics<cr>", "document"},
        q = {"<cmd>TroubleToggle quickfix<cr>", "quickfix"},
        l = {"<cmd>TroubleToggle loclist<cr>", "loclist"},
        r = {"<cmd>TroubleToggle lsp_references<cr>", "references"}
    },

-- " Available Debug Adapters:
-- "   https://microsoft.github.io/debug-adapter-protocol/implementors/adapters/
-- " 
-- " Adapter configuration and installation instructions:
-- "   https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
-- " 
-- " Debug Adapter protocol:
-- "   https://microsoft.github.io/debug-adapter-protocol/
-- " Debugging
-- command! DebugToggleBreakpoint lua require'dap'.toggle_breakpoint()
-- command! DebugStart lua require'dap'.continue()
-- command! DebugContinue lua require'dap'.continue()
-- command! DebugStepOver lua require'dap'.step_over()
-- command! DebugStepOut lua require'dap'.step_out()
-- command! DebugStepInto lua require'dap'.step_into()
-- command! DebugToggleRepl lua require'dap'.repl.toggle()
-- command! DebugGetSession lua require'dap'.session()
    D = {
        name = "Debug",
        b = {"<cmd>DebugToggleBreakpoint<cr>", "Toggle Breakpoint"},
        c = {"<cmd>DebugContinue<cr>", "Continue"},
        i = {"<cmd>DebugStepInto<cr>", "Step Into"},
        o = {"<cmd>DebugStepOver<cr>", "Step Over"},
        r = {"<cmd>DebugToggleRepl<cr>", "Toggle Repl"},
        s = {"<cmd>DebugStart<cr>", "Start"}
    },
    g = {
        name = "Git",
        j = {"<cmd>lua require 'lv-utils'.next_hunk()<cr>", "Next Hunk"},
        k = {"<cmd>lua require 'lv-utils'.prev_hunk()<cr>", "Prev Hunk"},
        l = {"<cmd>lua require 'lv-utils'.blame_line()<cr>", "Blame"},
        p = {"<cmd>lua require 'lv-utils'.preview_hunk()<cr>", "Preview Hunk"},
        r = {"<cmd>lua require 'lv-utils'.reset_hunk()<cr>", "Reset Hunk"},
        R = {"<cmd>lua require 'lv-utils'.reset_buffer()<cr>", "Reset Buffer"},
        s = {"<cmd>lua require 'lv-utils'.stage_hunk()<cr>", "Stage Hunk"},
        u = {"<cmd>lua require 'lv-utils'.undo_stage_hunk()<cr>", "Undo Stage Hunk"},
        o = {"<cmd>Telescope git_status<cr>", "Open changed file"},
        b = {"<cmd>Telescope git_branches<cr>", "Checkout branch"},
        c = {"<cmd>Telescope git_commits<cr>", "Checkout commit"},
        C = {"<cmd>Telescope git_bcommits<cr>", "Checkout commit(for current file)"}
    },
    l = {
        name = "LSP",
        a = {"<cmd>Lspsaga code_action<cr>", "Code Action"},
        A = {"<cmd>Lspsaga range_code_action<cr>", "Selected Action"},
        d = {"<cmd>Telescope lsp_document_diagnostics<cr>", "Document Diagnostics"},
        D = {"<cmd>Telescope lsp_workspace_diagnostics<cr>", "Workspace Diagnostics"},
        f = {"<cmd>lua require 'lv-utils'.formatting()<cr>", "Format"},
        h = {"<cmd>Lspsaga hover_doc<cr>", "Hover Doc"},
        i = {"<cmd>LspInfo<cr>", "Info"},
        l = {"<cmd>Lspsaga lsp_finder<cr>", "LSP Finder"},
        L = {"<cmd>Lspsaga show_line_diagnostics<cr>", "Line Diagnostics"},
        p = {"<cmd>Lspsaga preview_definition<cr>", "Preview Definition"},
        q = {"<cmd>Telescope quickfix<cr>", "Quickfix"},
        r = {"<cmd>Lspsaga rename<cr>", "Rename"},
        t = {"<cmd>LspTypeDefinition<cr>", "Type Definition"},
        x = {"<cmd>cclose<cr>", "Close Quickfix"},
        s = {"<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols"},
        S = {"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols"}
    },
    r = {
        name = "Replace",
        f = {"<cmd>lua require('spectre').open_file_search()<cr>", "Current File"},
        p = {"<cmd>lua require('spectre').open()<cr>", "Project"}
    },
    s = {
        name = "Search",
        b = {"<cmd>Telescope git_branches<cr>", "Checkout branch"},
        c = {"<cmd>Telescope colorscheme<cr>", "Colorscheme"},
        d = {"<cmd>Telescope lsp_document_diagnostics<cr>", "Document Diagnostics"},
        D = {"<cmd>Telescope lsp_workspace_diagnostics<cr>", "Workspace Diagnostics"},
        f = {"<cmd>Telescope find_files<cr>", "Find File"},
        h = {"<cmd>Telescope help_tags<cr>", "Find Help"},
        m = {"<cmd>Telescope marks<cr>", "Marks"},
        M = {"<cmd>Telescope man_pages<cr>", "Man Pages"},
        r = {"<cmd>Telescope oldfiles<cr>", "Open Recent File"},
        R = {"<cmd>Telescope registers<cr>", "Registers"},
        t = {"<cmd>Telescope live_grep<cr>", "Text"}
    },
    S = {
        name = "Session",
        s = {"<cmd>SessionSave<cr>", "Save Session"},
        l = {"<cmd>SessionLoad<cr>", "Load Session"}
    },
    -- extras
    -- z = {
    --     name = "Zen",
    --     s = {"<cmd>TZBottom<cr>", "toggle status line"},
    --     t = {"<cmd>TZTop<cr>", "toggle tab bar"},
    --     z = {"<cmd>TZAtaraxis<cr>", "toggle zen"}
    -- }
}

if O.extras then
    mappings["L"] = {
        name = "+Latex",
        c = {"<cmd>VimtexCompile<cr>", "Toggle Compilation Mode"},
        f = {"<cmd>call vimtex#fzf#run()<cr>", "Fzf Find"},
        i = {"<cmd>VimtexInfo<cr>", "Project Information"},
        s = {"<cmd>VimtexStop<cr>", "Stop Project Compilation"},
        t = {"<cmd>VimtexTocToggle<cr>", "Toggle Table Of Content"},
        v = {"<cmd>VimtexView<cr>", "View PDF"}
    }
end
-- TODO come back and fix visual mappings
-- local visualOpts = {
--     mode = "v", -- Visual mode
--     prefix = "<leader>",
--     buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
--     silent = true, -- use `silent` when creating keymaps
--     noremap = true, -- use `noremap` when creating keymaps
--     nowait = false -- use `nowait` when creating keymaps
-- }

-- local visualMappings = {
    -- ["/"] = {"<cmd>CommentToggle<cr>", "Comment"},
    -- r = {
        -- name = "Replace",
        -- f = {"<cmd>lua require('spectre').open_visual({path = vim.fn.expand('%')})<cr>", "File"},
        -- p = {"<cmd>lua require('spectre').open_visual()<cr>", "Project"}
    -- }
-- }

local wk = require("which-key")
wk.register(mappings, opts)
-- wk.register(visualMappings, visualOpts)


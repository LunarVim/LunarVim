local M = {}

M.config = function()
    local g = vim.g

    vim.o.termguicolors = true

    g.nvim_tree_side = "left"
    g.nvim_tree_width = 30
    g.nvim_tree_ignore = {".git", "node_modules", ".cache"}
    g.nvim_tree_auto_open = 1
    g.nvim_tree_auto_close = 0
    g.nvim_tree_quit_on_open = 0
    g.nvim_tree_follow = 1
    g.nvim_tree_indent_markers = 1
    g.nvim_tree_hide_dotfiles = 1
    g.nvim_tree_git_hl = 1
    g.nvim_tree_root_folder_modifier = ":t"
    g.nvim_tree_tab_open = 0
    g.nvim_tree_allow_resize = 1
    g.nvim_tree_lsp_diagnostics = 1
    g.nvim_tree_auto_ignore_ft = {'startify', 'dashboard'}

    g.nvim_tree_show_icons = {
        git = 1,
        folders = 1,
        files = 1,
        folder_arrows = 1
    }

    g.nvim_tree_icons = {
     default= '',
     symlink= '',
     git= {
       unstaged= "",
       staged= "✓",
       unmerged= "",
       renamed= "➜",
       untracked= "★",
       deleted= "",
       ignored= "◌"
       },
     folder= {
       arrow_open= "",
       arrow_closed= "",
       default= "",
       open= "",
       empty= "",
       empty_open= "",
       symlink= "",
       symlink_open= "",
       },
       lsp= {
         hint= "",
         info= "",
         warning= "",
         error= "",
       }
     }

    local tree_cb = require"nvim-tree.config".nvim_tree_callback

    g.nvim_tree_bindings = {
        { key = {"u"}, cb = tree_cb(":lua require'some_module'.some_function()<cr>") },
        { key= {"<CR>"}, cb = tree_cb("edit") },
        { key= {"l"}, cb = tree_cb("edit") },
        { key= {"o"}, cb = tree_cb("edit") },
        { key= {"h"}, cb = tree_cb("close_node") },
        { key= {"<2-LeftMouse>"}, cb = tree_cb("edit") },
        { key= {"<2-RightMouse>"}, cb = tree_cb("cd") },
        { key= {"<C-]>"}, cb = tree_cb("cd") },
        { key= {"<C-v>"}, cb = tree_cb("vsplit") },
        { key= {"v"}, cb = tree_cb("vsplit") },
        { key= {"<C-x>"}, cb = tree_cb("split") },
        { key= {"<C-t>"}, cb = tree_cb("tabnew") },
        { key= {"<"}, cb = tree_cb("prev_sibling") },
        { key= {">"}, cb = tree_cb("next_sibling") },
        { key= {"<BS>"}, cb = tree_cb("close_node") },
        { key= {"<S-CR>"}, cb = tree_cb("close_node") },
        { key= {"<Tab>"}, cb = tree_cb("preview") },
        { key= {"I"}, cb = tree_cb("toggle_ignored") },
        { key= {"H"}, cb = tree_cb("toggle_dotfiles") },
        { key= {"R"}, cb = tree_cb("refresh") },
        { key= {"a"}, cb = tree_cb("create") },
        { key= {"d"}, cb = tree_cb("remove") },
        { key= {"r"}, cb = tree_cb("rename") },
        { key= {"<C-r>"}, cb = tree_cb("full_rename") },
        { key= {"x"}, cb = tree_cb("cut") },
        { key= {"c"}, cb = tree_cb("copy") },
        { key= {"p"}, cb = tree_cb("paste") },
        { key= {"y"}, cb = tree_cb("copy_name") },
        { key= {"Y"}, cb = tree_cb("copy_path") },
        { key= {"gy"}, cb = tree_cb("copy_absolute_path") },
        { key= {"[c"}, cb = tree_cb("prev_git_item") },
        { key= {"]c"}, cb = tree_cb("next_git_item") },
        { key= {"-"}, cb = tree_cb("dir_up") },
        { key= {"q"}, cb = tree_cb("close") }
    }
end

local view = require 'nvim-tree.view'

M.toggle_tree = function()
    if view.win_open() then
        require'nvim-tree'.close()
        require'bufferline.state'.set_offset(0)
    else
        require'bufferline.state'.set_offset(31, 'File Explorer')
        require'nvim-tree'.find_file(true)
    end

end

return M

-- --if not package.loaded['nvim-tree.view'] then
-- --  return
-- --end
--
local M = {}
local status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not status_ok then
  return
end
--
M.config = function()
  local g = vim.g

  vim.o.termguicolors = true

  g.nvim_tree_side = O.nvim_tree.side
  g.nvim_tree_width = O.nvim_tree.width
  g.nvim_tree_ignore = O.nvim_tree.ignore
  g.nvim_tree_auto_open = O.nvim_tree.auto_open
  g.nvim_tree_auto_close = O.nvim_tree.auto_close
  g.nvim_tree_quit_on_open = O.nvim_tree.quit_on_open
  g.nvim_tree_follow = O.nvim_tree.follow
  g.nvim_tree_indent_markers = O.nvim_tree.indent_markers
  g.nvim_tree_hide_dotfiles = O.nvim_tree.hide_dotfiles
  g.nvim_tree_git_hl = O.nvim_tree.git_hl
  g.nvim_tree_root_folder_modifier = O.nvim_tree.root_folder_modifier
  g.nvim_tree_tab_open = O.nvim_tree.tab_open
  g.nvim_tree_allow_resize = O.nvim_tree.allow_resize
  g.nvim_tree_lsp_diagnostics = O.nvim_tree.lsp_diagnostics
  g.nvim_tree_auto_ignore_ft = O.nvim_tree.auto_ignore_ft

  g.nvim_tree_show_icons = {
    git = O.nvim_tree.show_icons.git,
    folders = O.nvim_tree.show_icons.folders,
    files = O.nvim_tree.show_icons.files,
    folder_arrows = O.nvim_tree.show_icons.folder_arrows,
  }

  vim.g.nvim_tree_icons = {
    default = O.nvim_tree.tree_icons.default,
    symlink = O.nvim_tree.tree_icons.symlink,
    git = {
      unstaged = O.nvim_tree.tree_icons.git.unstaged,
      staged = O.nvim_tree.tree_icons.git.staged,
      unmerged = O.nvim_tree.tree_icons.unmerged,
      renamed = O.nvim_tree.tree_icons.renamed,
      deleted = O.nvim_tree.tree_icons.deleted,
      untracked = O.nvim_tree.tree_icons.untracked,
      ignored = O.nvim_tree.tree_icons.ignored,
    },
    folder = {
      default = O.nvim_tree.folder.default,
      open = O.nvim_tree.folder.open,
      empty = O.nvim_tree.folder.empty,
      empty_open = O.nvim_tree.folder.empty_open,
      symlink = O.nvim_tree.folder.symlink,
    },
  }
  local tree_cb = nvim_tree_config.nvim_tree_callback

  vim.g.nvim_tree_bindings = {
    { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
    { key = "h", cb = tree_cb "close_node" },
    { key = "v", cb = tree_cb "vsplit" },
  }
end

local view_status_ok, view = pcall(require, "nvim-tree.view")
if not view_status_ok then
  return
end
M.toggle_tree = function()
  if view.win_open() then
    require("nvim-tree").close()
    if O.nvim_tree.side == "left" and package.loaded["bufferline.state"] then
      require("bufferline.state").set_offset(0)
    end
  else
    if O.nvim_tree.side == "left" and package.loaded["bufferline.state"] then
      -- require'bufferline.state'.set_offset(31, 'File Explorer')
      require("bufferline.state").set_offset(O.nvim_tree.width + 1, "")
    end
    require("nvim-tree").find_file(true)
  end
end
--
return M

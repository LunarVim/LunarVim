local M = {}
local Log = require "core.log"
--
M.config = function()
  lvim.builtin.nvimtree = {
    active = true,
    side = "left",
    width = 30,
    show_icons = {
      git = 1,
      folders = 1,
      files = 1,
      folder_arrows = 1,
      tree_width = 30,
    },
    ignore = { ".git", "node_modules", ".cache" },
    auto_open = 1,
    auto_close = 1,
    quit_on_open = 0,
    follow = 1,
    hide_dotfiles = 1,
    git_hl = 1,
    root_folder_modifier = ":t",
    tab_open = 0,
    allow_resize = 1,
    lsp_diagnostics = 1,
    auto_ignore_ft = { "startify", "dashboard" },
    icons = {
      default = "",
      symlink = "",
      git = {
        unstaged = "",
        staged = "S",
        unmerged = "",
        renamed = "➜",
        deleted = "",
        untracked = "U",
        ignored = "◌",
      },
      folder = {
        default = "",
        open = "",
        empty = "",
        empty_open = "",
        symlink = "",
      },
    },
  }
end
--
M.setup = function()
  local status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
  if not status_ok then
    Log:get_default().error "Failed to load nvim-tree.config"
    return
  end
  local g = vim.g

  for opt, val in pairs(lvim.builtin.nvimtree) do
    g["nvim_tree_" .. opt] = val
  end

  local tree_cb = nvim_tree_config.nvim_tree_callback

  if not g.nvim_tree_bindings then
    g.nvim_tree_bindings = {
      { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
      { key = "h", cb = tree_cb "close_node" },
      { key = "v", cb = tree_cb "vsplit" },
      { key = "q", cb = ":lua require('core.nvimtree').toggle_tree()<cr>" },
    }
  end
end
--
M.focus_or_close = function()
  local view_status_ok, view = pcall(require, "nvim-tree.view")
  if not view_status_ok then
    return
  end
  local a = vim.api

  local curwin = a.nvim_get_current_win()
  local curbuf = a.nvim_win_get_buf(curwin)
  local bufnr = view.View.bufnr
  local winnr = view.get_winnr()

  if view.win_open() then
    if curwin == winnr and curbuf == bufnr then
      view.close()
      if package.loaded["bufferline.state"] then
        require("bufferline.state").set_offset(0)
      end
    else
      view.focus()
    end
  else
    view.open()
    if package.loaded["bufferline.state"] and lvim.builtin.nvimtree.side == "left" then
      -- require'bufferline.state'.set_offset(lvim.builtin.nvimtree.width + 1, 'File Explorer')
      require("bufferline.state").set_offset(lvim.builtin.nvimtree.width + 1, "")
    end
  end
end
--
M.toggle_tree = function()
  local view_status_ok, view = pcall(require, "nvim-tree.view")
  if not view_status_ok then
    return
  end
  if view.win_open() then
    require("nvim-tree").close()
    if package.loaded["bufferline.state"] then
      require("bufferline.state").set_offset(0)
    end
  else
    if package.loaded["bufferline.state"] and lvim.builtin.nvimtree.side == "left" then
      -- require'bufferline.state'.set_offset(lvim.builtin.nvimtree.width + 1, 'File Explorer')
      require("bufferline.state").set_offset(lvim.builtin.nvimtree.width + 1, "")
    end
    require("nvim-tree").toggle()
  end
end
--
function M.change_tree_dir(dir)
  if vim.g.loaded_tree then
    require("nvim-tree.lib").change_dir(dir)
  end
end
--
return M

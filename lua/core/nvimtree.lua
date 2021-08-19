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

  -- Implicitly update nvim-tree when project module is active
  if lvim.builtin.project.active then
    vim.g.nvim_tree_update_cwd = 1
    vim.g.nvim_tree_respect_buf_cwd = 1
  end

  local tree_cb = nvim_tree_config.nvim_tree_callback

  if not g.nvim_tree_bindings then
    g.nvim_tree_bindings = {
      { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
      { key = "h", cb = tree_cb "close_node" },
      { key = "v", cb = tree_cb "vsplit" },
    }
  end

  vim.cmd "au FileType NvimTree lua require('core.nvimtree').on_type()"
end
--
M.on_type = function()
  local buf = vim.fn.expand "<abuf>"
  vim.cmd("au BufWinEnter <buffer=" .. buf .. "> lua require('core.nvimtree').on_open()")
  vim.cmd("au WinClosed   <buffer=" .. buf .. "> lua require('core.nvimtree').on_close()")
end
--
M.on_open = function()
  if package.loaded["bufferline.state"] and lvim.builtin.nvimtree.side == "left" then
    require("bufferline.state").set_offset(lvim.builtin.nvimtree.width + 1, "")
  end
end
--
M.on_close = function()
  if package.loaded["bufferline.state"] then
    require("bufferline.state").set_offset(0)
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
    else
      view.focus()
    end
  else
    view.open()
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
  else
    require("nvim-tree").toggle()
  end
end
--
function M.change_tree_dir(dir)
  local lib_status_ok, lib = pcall(require, "nvim-tree.lib")
  if lib_status_ok then
    lib.change_dir(dir)
  end
end
--
return M

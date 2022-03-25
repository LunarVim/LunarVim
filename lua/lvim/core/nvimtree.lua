local M = {}
local Log = require "lvim.core.log"

function M.config()
  lvim.builtin.nvimtree = {
    active = true,
    on_config_done = nil,
    setup = {
      disable_netrw = true,
      hijack_netrw = true,
      open_on_setup = false,
      ignore_buffer_on_setup = false,
      ignore_ft_on_setup = {
        "startify",
        "dashboard",
        "alpha",
      },
      auto_reload_on_write = true,
      hijack_unnamed_buffer_when_opening = false,
      hijack_directories = {
        enable = true,
        auto_open = true,
      },
      update_to_buf_dir = {
        enable = true,
        auto_open = true,
      },
      auto_close = false,
      open_on_tab = false,
      hijack_cursor = false,
      update_cwd = false,
      diagnostics = {
        enable = true,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {},
      },
      system_open = {
        cmd = nil,
        args = {},
      },
      git = {
        enable = true,
        ignore = false,
        timeout = 200,
      },
      view = {
        width = 30,
        height = 30,
        hide_root_folder = false,
        side = "left",
        auto_resize = false,
        mappings = {
          custom_only = false,
          list = {},
        },
        number = false,
        relativenumber = false,
        signcolumn = "yes",
      },
      filters = {
        dotfiles = false,
        custom = { "node_modules", ".cache" },
      },
      trash = {
        cmd = "trash",
        require_confirm = true,
      },
      actions = {
        change_dir = {
          global = false,
        },
        open_file = {
          resize_window = true,
          quit_on_open = false,
        },
        window_picker = {
          enable = false,
          chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
          exclude = {},
        },
      },
    },
    show_icons = {
      git = 1,
      folders = 1,
      files = 1,
      folder_arrows = 1,
    },
    git_hl = 1,
    root_folder_modifier = ":t",
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
  lvim.builtin.which_key.mappings["e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" }
end

function M.setup()
  local status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
  if not status_ok then
    Log:error "Failed to load nvim-tree.config"
    return
  end

  for opt, val in pairs(lvim.builtin.nvimtree) do
    vim.g["nvim_tree_" .. opt] = val
  end

  -- Implicitly update nvim-tree when project module is active
  if lvim.builtin.project.active then
    lvim.builtin.nvimtree.respect_buf_cwd = 1
    lvim.builtin.nvimtree.setup.update_cwd = true
    lvim.builtin.nvimtree.setup.update_focused_file = { enable = true, update_cwd = true }
  end

  local function telescope_find_files(_)
    require("lvim.core.nvimtree").start_telescope "find_files"
  end
  local function telescope_live_grep(_)
    require("lvim.core.nvimtree").start_telescope "live_grep"
  end

  -- Add useful keymaps
  if #lvim.builtin.nvimtree.setup.view.mappings.list == 0 then
    lvim.builtin.nvimtree.setup.view.mappings.list = {
      { key = { "l", "<CR>", "o" }, action = "edit", mode = "n" },
      { key = "h", action = "close_node" },
      { key = "v", action = "vsplit" },
      { key = "C", action = "cd" },
      { key = "gtf", action = "telescope_find_files", action_cb = telescope_find_files },
      { key = "gtg", action = "telescope_live_grep", action_cb = telescope_live_grep },
    }
  end

  if lvim.builtin.nvimtree.on_config_done then
    lvim.builtin.nvimtree.on_config_done(nvim_tree_config)
  end

  require("nvim-tree").setup(lvim.builtin.nvimtree.setup)
end

function M.start_telescope(telescope_mode)
  local node = require("nvim-tree.lib").get_node_at_cursor()
  local abspath = node.link_to or node.absolute_path
  local is_folder = node.open ~= nil
  local basedir = is_folder and abspath or vim.fn.fnamemodify(abspath, ":h")
  require("telescope.builtin")[telescope_mode] {
    cwd = basedir,
  }
end

return M

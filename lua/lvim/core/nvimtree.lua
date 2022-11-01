local M = {}
local Log = require "lvim.core.log"

function M.config()
  lvim.builtin.nvimtree = {
    active = true,
    on_config_done = nil,
    setup = {
      ignore_ft_on_setup = {
        "startify",
        "dashboard",
        "alpha",
      },
      auto_reload_on_write = false,
      hijack_directories = {
        enable = false,
      },
      update_cwd = true,
      diagnostics = {
        enable = lvim.use_icons,
        show_on_dirs = false,
        icons = {
          hint = lvim.icons.diagnostics.BoldHint,
          info = lvim.icons.diagnostics.BoldInformation,
          warning = lvim.icons.diagnostics.BoldWarning,
          error = lvim.icons.diagnostics.BoldError,
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
        hide_root_folder = false,
        side = "left",
        mappings = {
          custom_only = false,
          list = {},
        },
        number = false,
        relativenumber = false,
        signcolumn = "yes",
      },
      renderer = {
        indent_markers = {
          enable = false,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            none = " ",
          },
        },
        icons = {
          webdev_colors = lvim.use_icons,
          show = {
            git = lvim.use_icons,
            folder = lvim.use_icons,
            file = lvim.use_icons,
            folder_arrow = lvim.use_icons,
          },
          glyphs = {
            default = lvim.icons.ui.Text,
            symlink = lvim.icons.ui.FileSymlink,
            git = {
              deleted = lvim.icons.git.FileDeleted,
              ignored = lvim.icons.git.FileIgnored,
              renamed = lvim.icons.git.FileRenamed,
              staged = lvim.icons.git.FileStaged,
              unmerged = lvim.icons.git.FileUnmerged,
              unstaged = lvim.icons.git.FileUnstaged,
              untracked = lvim.icons.git.FileUntracked,
            },
            folder = {
              default = lvim.icons.ui.Folder,
              empty = lvim.icons.ui.EmptyFolder,
              empty_open = lvim.icons.ui.EmptyFolderOpen,
              open = lvim.icons.ui.FolderOpen,
              symlink = lvim.icons.ui.FolderSymlink,
            },
          },
        },
        highlight_git = true,
        group_empty = false,
        root_folder_modifier = ":t",
      },
      filters = {
        dotfiles = false,
        custom = { "node_modules", "\\.cache" },
        exclude = {},
      },
      trash = {
        cmd = "trash",
        require_confirm = true,
      },
      log = {
        enable = false,
        truncate = false,
        types = {
          all = false,
          config = false,
          copy_paste = false,
          diagnostics = false,
          git = false,
          profile = false,
        },
      },
      actions = {
        use_system_clipboard = true,
        change_dir = {
          enable = true,
          global = false,
          restrict_above_cwd = false,
        },
        open_file = {
          quit_on_open = false,
          resize_window = false,
          window_picker = {
            enable = true,
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
              filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
              buftype = { "nofile", "terminal", "help" },
            },
          },
        },
      },
    },
  }
end

function M.setup()
  local status_ok, nvim_tree = pcall(require, "nvim-tree")
  if not status_ok then
    Log:error "Failed to load nvim-tree"
    return
  end

  if lvim.builtin.nvimtree._setup_called then
    Log:debug "ignoring repeated setup call for nvim-tree, see kyazdani42/nvim-tree.lua#1308"
    return
  end

  lvim.builtin.which_key.mappings["e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" }
  lvim.builtin.nvimtree._setup_called = true

  -- Implicitly update nvim-tree when project module is active
  if lvim.builtin.project.active then
    lvim.builtin.nvimtree.setup.respect_buf_cwd = true
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

  nvim_tree.setup(lvim.builtin.nvimtree.setup)

  if lvim.builtin.nvimtree.on_config_done then
    lvim.builtin.nvimtree.on_config_done(nvim_tree)
  end
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

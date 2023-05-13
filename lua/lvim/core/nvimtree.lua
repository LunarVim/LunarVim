local M = {}
local Log = require "lvim.core.log"

function M.config()
  lvim.builtin.nvimtree = {
    active = true,
    on_config_done = nil,
    setup = {
      auto_reload_on_write = false,
      disable_netrw = false,
      hijack_cursor = false,
      hijack_netrw = true,
      hijack_unnamed_buffer_when_opening = false,
      sort_by = "name",
      root_dirs = {},
      prefer_startup_root = false,
      sync_root_with_cwd = true,
      reload_on_bufenter = false,
      respect_buf_cwd = false,
      on_attach = "default",
      remove_keymaps = false,
      select_prompts = false,
      view = {
        adaptive_size = false,
        centralize_selection = true,
        width = 30,
        hide_root_folder = false,
        side = "left",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
        float = {
          enable = false,
          quit_on_focus_loss = true,
          open_win_config = {
            relative = "editor",
            border = "rounded",
            width = 30,
            height = 30,
            row = 1,
            col = 1,
          },
        },
      },
      renderer = {
        add_trailing = false,
        group_empty = false,
        highlight_git = true,
        full_name = false,
        highlight_opened_files = "none",
        root_folder_label = ":t",
        indent_width = 2,
        indent_markers = {
          enable = false,
          inline_arrows = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            none = " ",
          },
        },
        icons = {
          webdev_colors = lvim.use_icons,
          git_placement = "before",
          padding = " ",
          symlink_arrow = " ➛ ",
          show = {
            file = lvim.use_icons,
            folder = lvim.use_icons,
            folder_arrow = lvim.use_icons,
            git = lvim.use_icons,
          },
          glyphs = {
            default = lvim.icons.ui.Text,
            symlink = lvim.icons.ui.FileSymlink,
            bookmark = lvim.icons.ui.BookMark,
            folder = {
              arrow_closed = lvim.icons.ui.TriangleShortArrowRight,
              arrow_open = lvim.icons.ui.TriangleShortArrowDown,
              default = lvim.icons.ui.Folder,
              open = lvim.icons.ui.FolderOpen,
              empty = lvim.icons.ui.EmptyFolder,
              empty_open = lvim.icons.ui.EmptyFolderOpen,
              symlink = lvim.icons.ui.FolderSymlink,
              symlink_open = lvim.icons.ui.FolderOpen,
            },
            git = {
              unstaged = lvim.icons.git.FileUnstaged,
              staged = lvim.icons.git.FileStaged,
              unmerged = lvim.icons.git.FileUnmerged,
              renamed = lvim.icons.git.FileRenamed,
              untracked = lvim.icons.git.FileUntracked,
              deleted = lvim.icons.git.FileDeleted,
              ignored = lvim.icons.git.FileIgnored,
            },
          },
        },
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
        symlink_destination = true,
      },
      hijack_directories = {
        enable = false,
        auto_open = true,
      },
      update_focused_file = {
        enable = true,
        debounce_delay = 15,
        update_root = true,
        ignore_list = {},
      },
      diagnostics = {
        enable = lvim.use_icons,
        show_on_dirs = false,
        show_on_open_dirs = true,
        debounce_delay = 50,
        severity = {
          min = vim.diagnostic.severity.HINT,
          max = vim.diagnostic.severity.ERROR,
        },
        icons = {
          hint = lvim.icons.diagnostics.BoldHint,
          info = lvim.icons.diagnostics.BoldInformation,
          warning = lvim.icons.diagnostics.BoldWarning,
          error = lvim.icons.diagnostics.BoldError,
        },
      },
      filters = {
        dotfiles = false,
        git_clean = false,
        no_buffer = false,
        custom = { "node_modules", "\\.cache" },
        exclude = {},
      },
      filesystem_watchers = {
        enable = true,
        debounce_delay = 50,
        ignore_dirs = {},
      },
      git = {
        enable = true,
        ignore = false,
        show_on_dirs = true,
        show_on_open_dirs = true,
        timeout = 200,
      },
      actions = {
        use_system_clipboard = true,
        change_dir = {
          enable = true,
          global = false,
          restrict_above_cwd = false,
        },
        expand_all = {
          max_folder_discovery = 300,
          exclude = {},
        },
        file_popup = {
          open_win_config = {
            col = 1,
            row = 1,
            relative = "cursor",
            border = "shadow",
            style = "minimal",
          },
        },
        open_file = {
          quit_on_open = false,
          resize_window = false,
          window_picker = {
            enable = true,
            picker = "default",
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
              filetype = { "notify", "lazy", "qf", "diff", "fugitive", "fugitiveblame" },
              buftype = { "nofile", "terminal", "help" },
            },
          },
        },
        remove_file = {
          close_window = true,
        },
      },
      trash = {
        cmd = "trash",
        require_confirm = true,
      },
      live_filter = {
        prefix = "[FILTER]: ",
        always_show_folders = true,
      },
      tab = {
        sync = {
          open = false,
          close = false,
          ignore = {},
        },
      },
      notify = {
        threshold = vim.log.levels.INFO,
      },
      log = {
        enable = false,
        truncate = false,
        types = {
          all = false,
          config = false,
          copy_paste = false,
          dev = false,
          diagnostics = false,
          git = false,
          profile = false,
          watcher = false,
        },
      },
      system_open = {
        cmd = nil,
        args = {},
      },
    },
  }
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

local function on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function telescope_find_files(_)
    require("lvim.core.nvimtree").start_telescope "find_files"
  end

  local function telescope_live_grep(_)
    require("lvim.core.nvimtree").start_telescope "live_grep"
  end

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  local useful_keys = {
    ["l"] = { api.node.open.edit, opts "Open" },
    ["o"] = { api.node.open.edit, opts "Open" },
    ["<CR>"] = { api.node.open.edit, opts "Open" },
    ["v"] = { api.node.open.vertical, opts "Open: Vertical Split" },
    ["h"] = { api.node.navigate.parent_close, opts "Close Directory" },
    ["C"] = { api.tree.change_root_to_node, opts "CD" },
    ["gtg"] = { telescope_live_grep, opts "Telescope Live Grep" },
    ["gtf"] = { telescope_find_files, opts "Telescope Find File" },
  }

  require("lvim.keymappings").load_mode("n", useful_keys)
end

function M.setup()
  local status_ok, nvim_tree = pcall(require, "nvim-tree")

  if not status_ok then
    Log:error "Failed to load nvim-tree"
    return
  end

  -- Implicitly update nvim-tree when project module is active
  if lvim.builtin.project.active then
    lvim.builtin.nvimtree.setup.respect_buf_cwd = true
    lvim.builtin.nvimtree.setup.update_cwd = true
    lvim.builtin.nvimtree.setup.update_focused_file.enable = true
    lvim.builtin.nvimtree.setup.update_focused_file.update_cwd = true
  end

  -- Add useful keymaps
  if lvim.builtin.nvimtree.setup.on_attach == "default" then
    lvim.builtin.nvimtree.setup.on_attach = on_attach
  end

  nvim_tree.setup(lvim.builtin.nvimtree.setup)

  if lvim.builtin.nvimtree.on_config_done then
    lvim.builtin.nvimtree.on_config_done(nvim_tree)
  end
end

return M

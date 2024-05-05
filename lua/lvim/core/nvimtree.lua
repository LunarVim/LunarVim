local M = {}
local Log = require "lvim.core.log"

function M.config()
  lvim.builtin.nvimtree = {
    active = true,
    on_config_done = nil,
    setup = {
      experimental = {},
      auto_reload_on_write = false,
      disable_netrw = false,
      hijack_cursor = false,
      hijack_netrw = true,
      hijack_unnamed_buffer_when_opening = false,
      sort = {
        sorter = "name",
        folders_first = true,
        files_first = false,
      },
      root_dirs = {},
      prefer_startup_root = false,
      sync_root_with_cwd = true,
      reload_on_bufenter = false,
      respect_buf_cwd = false,
      on_attach = "default",
      select_prompts = false,
      view = {
        adaptive_size = false,
        centralize_selection = true,
        width = 30,
        cursorline = true,
        debounce_delay = 15,
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
        highlight_git = "name",
        highlight_opened_files = "none",
        root_folder_label = ":t",
        full_name = false,
        indent_width = 2,
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
        symlink_destination = true,
        highlight_diagnostics = "none",
        highlight_modified = "none",
        highlight_bookmarks = "none",
        highlight_clipboard = "name",
        indent_markers = {
          enable = false,
          inline_arrows = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            bottom = "─",
            none = " ",
          },
        },
        icons = {
          webdev_colors = lvim.use_icons,

          web_devicons = {
            file = {
              enable = lvim.use_icons,
              color = lvim.use_icons,
            },
            folder = {
              enable = false,
              color = lvim.use_icons,
            },
          },
          git_placement = "before",
          padding = " ",
          symlink_arrow = " ➛ ",
          modified_placement = "after",
          diagnostics_placement = "signcolumn",
          bookmarks_placement = "signcolumn",
          show = {
            file = lvim.use_icons,
            folder = lvim.use_icons,
            folder_arrow = lvim.use_icons,
            git = lvim.use_icons,
            modified = lvim.use_icons,
            diagnostics = lvim.use_icons,
            bookmarks = lvim.use_icons,
          },
          glyphs = {
            default = lvim.icons.ui.Text,
            symlink = lvim.icons.ui.FileSymlink,
            bookmark = lvim.icons.ui.BookMark,
            modified = lvim.icons.ui.Circle,
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
      },
      hijack_directories = {
        enable = false,
        auto_open = true,
      },
      update_focused_file = {
        enable = true,
        update_root = {
          enable = true,
          ignore_list = {},
        },
        exclude = false,
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
        enable = true,
        dotfiles = false,
        git_clean = false,
        git_ignored = false,
        no_bookmark = false,
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
        show_on_dirs = true,
        show_on_open_dirs = true,
        disable_for_dirs = {},
        timeout = 400,
        cygwin_support = false,
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
          eject = true,
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
        cmd = "gio trash",
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
        absolute_path = true,
      },
      ui = {
        confirm = {
          remove = true,
          trash = true,
          default_yes = false,
        },
      },
      modified = {
        enable = false,
        show_on_dirs = true,
        show_on_open_dirs = true,
      },
      help = {
        sort_by = "key",
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

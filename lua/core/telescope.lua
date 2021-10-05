local M = {}

local utils = require "utils"

function M.config()
  -- Define this minimal config so that it's available if telescope is not yet available.
  lvim.builtin.telescope = {
    ---@usage disable telescope completely [not recommeded]
    active = true,
    on_config_done = nil,
  }

  local status_ok, actions = pcall(require, "telescope.actions")
  if not status_ok then
    return
  end

  lvim.builtin.telescope = vim.tbl_extend("force", lvim.builtin.telescope, {
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "descending",
      layout_strategy = "horizontal",
      layout_config = {
        width = 0.75,
        prompt_position = "bottom",
        preview_cutoff = 120,
        horizontal = { mirror = false },
        vertical = { mirror = false },
      },
      file_sorter = require("telescope.sorters").get_fzy_sorter,
      file_ignore_patterns = {},
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      path_display = { shorten = 5 },
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      color_devicons = true,
      use_less = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

      -- Developer configurations: Not meant for general override
      -- buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
      mappings = {
        i = {
          ["<C-n>"] = actions.move_selection_next,
          ["<C-p>"] = actions.move_selection_previous,
          ["<C-c>"] = actions.close,
          ["<C-j>"] = actions.cycle_history_next,
          ["<C-k>"] = actions.cycle_history_prev,
          ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          ["<CR>"] = actions.select_default + actions.center,
          -- To disable a keymap, put [map] = false
          -- So, to not map "<C-n>", just put
          -- ["<c-t>"] = trouble.open_with_trouble,
          -- ["<c-x>"] = false,
          -- ["<esc>"] = actions.close,
          -- Otherwise, just set the mapping to the function that you want it to be.
          -- ["<C-i>"] = actions.select_horizontal,
          -- Add up multiple actions
          -- You can perform as many actions in a row as you like
          -- ["<CR>"] = actions.select_default + actions.center + my_cool_custom_action,
        },
        n = {
          ["<C-n>"] = actions.move_selection_next,
          ["<C-p>"] = actions.move_selection_previous,
          ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          -- ["<c-t>"] = trouble.open_with_trouble,
          -- ["<C-i>"] = my_cool_custom_action,
        },
      },
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      },
    },
  })
end

function M.find_lunarvim_files(opts)
  opts = opts or {}
  local themes = require "telescope.themes"
  local theme_opts = themes.get_ivy {
    sorting_strategy = "ascending",
    layout_strategy = "bottom_pane",
    prompt = ">> ",
    prompt_title = "~ LunarVim files ~",
    cwd = utils.join_paths(get_runtime_dir(), "lvim"),
    find_command = { "git", "ls-files" },
  }
  opts = vim.tbl_deep_extend("force", theme_opts, opts)
  require("telescope.builtin").find_files(opts)
end

function M.grep_lunarvim_files(opts)
  opts = opts or {}
  local themes = require "telescope.themes"
  local theme_opts = themes.get_ivy {
    sorting_strategy = "ascending",
    layout_strategy = "bottom_pane",
    prompt = ">> ",
    prompt_title = "~ search LunarVim ~",
    cwd = utils.join_paths(get_runtime_dir(), "lvim"),
  }
  opts = vim.tbl_deep_extend("force", theme_opts, opts)
  require("telescope.builtin").live_grep(opts)
end

function M.view_lunarvim_changelog()
  local finders = require "telescope.finders"
  local make_entry = require "telescope.make_entry"
  local pickers = require "telescope.pickers"
  local previewers = require "telescope.previewers"
  local actions = require "telescope.actions"
  local opts = {}

  local conf = require("telescope.config").values
  opts.entry_maker = make_entry.gen_from_git_commits(opts)

  pickers.new(opts, {
    prompt_title = "LunarVim changelog",

    finder = finders.new_oneshot_job(
      vim.tbl_flatten {
        "git",
        "log",
        "--pretty=oneline",
        "--abbrev-commit",
        "--",
        ".",
      },
      opts
    ),
    previewer = {
      previewers.git_commit_diff_to_parent.new(opts),
      previewers.git_commit_diff_to_head.new(opts),
      previewers.git_commit_diff_as_was.new(opts),
      previewers.git_commit_message.new(opts),
    },

    --TODO: consider opening a diff view when pressing enter
    attach_mappings = function(_, map)
      map("i", "<enter>", actions._close)
      map("n", "<enter>", actions._close)
      map("i", "<esc>", actions._close)
      map("n", "<esc>", actions._close)
      map("n", "q", actions._close)
      return true
    end,
    sorter = conf.file_sorter(opts),
  }):find()
end

function M.code_actions()
  local opts = {
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  }
  require("telescope.builtin").lsp_code_actions(require("telescope.themes").get_dropdown(opts))
end

function M.setup()
  local telescope = require "telescope"

  telescope.setup(lvim.builtin.telescope)
  if lvim.builtin.project.active then
    telescope.load_extension "projects"
  end

  if lvim.builtin.telescope.on_config_done then
    lvim.builtin.telescope.on_config_done(telescope)
  end
end

return M

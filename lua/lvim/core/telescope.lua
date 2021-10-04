local M = {}

local utils = require "utils"

local _, builtin = pcall(require, "telescope.builtin")
local _, finders = pcall(require, "telescope.finders")
local _, pickers = pcall(require, "telescope.pickers")
local _, sorters = pcall(require, "telescope.sorters")
local _, themes = pcall(require, "telescope.themes")
local _, actions = pcall(require, "telescope.actions")
local _, previewers = pcall(require, "telescope.previewers")
local _, make_entry = pcall(require, "telescope.make_entry")

function M.config()
  -- Define this minimal config so that it's available if telescope is not yet available.
  lvim.builtin.telescope = {
    ---@usage disable telescope completely [not recommeded]
    active = true,
    on_config_done = nil,
  }

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
        preview_cutoff = 120,
        horizontal = { mirror = false },
        vertical = { mirror = false },
      },
      file_sorter = sorters.fuzzy_with_index_bias,
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
      },
      pickers = {
        find_files = {
          find_command = { "fd", "--type=file", "--hidden", "--smart-case" },
        },
      },
      file_ignore_patterns = {},
      generic_sorter = sorters.get_generic_fuzzy_sorter,
      path_display = { shorten = 5 },
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      color_devicons = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      file_previewer = previewers.vim_buffer_cat.new,
      grep_previewer = previewers.vim_buffer_vimgrep.new,
      qflist_previewer = previewers.vim_buffer_qflist.new,
      ---@usage Mappings are fully customizable. Many familiar mapping patterns are setup as defaults.
      mappings = {
        i = {
          ["<C-n>"] = actions.move_selection_next,
          ["<C-p>"] = actions.move_selection_previous,
          ["<C-c>"] = actions.close,
          ["<C-j>"] = actions.cycle_history_next,
          ["<C-k>"] = actions.cycle_history_prev,
          ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          ["<CR>"] = actions.select_default + actions.center,
          ["<M-space>"] = actions.which_key,
        },
        n = {
          ["<C-n>"] = actions.move_selection_next,
          ["<C-p>"] = actions.move_selection_previous,
          ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          ["<M-space>"] = actions.which_key,
        },
      },
    },
    extensions = {
      fzf = { fuzzy = true, override_generic_sorter = true, override_file_sorter = true, case_mode = "smart_case" },
    },
  })
end

function M.find_lunarvim_files(opts)
  opts = opts or {}
  local theme_opts = themes.get_ivy {
    sorting_strategy = "ascending",
    layout_strategy = "bottom_pane",
    prompt_prefix = ">> ",
    prompt_title = "~ LunarVim files ~",
    cwd = get_runtime_dir(),
    search_dirs = { get_runtime_dir() .. "/lvim", lvim.lsp.templates_dir },
  }
  opts = vim.tbl_deep_extend("force", theme_opts, opts)
  builtin.find_files(opts)
end

function M.grep_lunarvim_files(opts)
  opts = opts or {}
  local theme_opts = themes.get_ivy {
    sorting_strategy = "ascending",
    layout_strategy = "bottom_pane",
    prompt_prefix = ">> ",
    prompt_title = "~ search LunarVim ~",
    cwd = get_runtime_dir(),
    search_dirs = { get_runtime_dir() .. "/lvim", lvim.lsp.templates_dir },
  }
  opts = vim.tbl_deep_extend("force", theme_opts, opts)
  builtin.live_grep(opts)
end

function M.view_lunarvim_changelog()
  local opts = {}
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
    sorter = sorters.fuzzy_with_index_bias,
  }):find()
end

function M.code_actions()
  local opts = {
    winblend = 15,
    layout_config = {
      prompt_position = "top",
      width = 80,
      height = 12,
    },
    borderchars = {
      prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
    border = {},
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

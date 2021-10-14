local M = {}

local _, sorters = pcall(require, "telescope.sorters")
local _, actions = pcall(require, "telescope.actions")
local _, previewers = pcall(require, "telescope.previewers")
local _, themes = pcall(require, "telescope.themes")
local _, builtin = pcall(require, "telescope.builtin")

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
      file_sorter = sorters.get_fuzzy_file,
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
  builtin.lsp_code_actions(themes.get_dropdown(opts))
end

function M.setup()
  local telescope = require "telescope"

  telescope.setup(lvim.builtin.telescope)
  if lvim.builtin.project.active then
    telescope.load_extension "projects"
  end

  if lvim.builtin.telescope.extensions.fzf then
    pcall(function()
      require("telescope").load_extension "fzf"
    end)
  end

  if lvim.builtin.telescope.on_config_done then
    lvim.builtin.telescope.on_config_done(telescope)
  end
end

return M

local M = {}

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
    config = {
      defaults = {
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        mappings = {
          i = {
            ["<C-n>"] = actions.move_selection_next,
            ["<C-p>"] = actions.move_selection_previous,
            ["<C-c>"] = actions.close,
            ["<C-j>"] = actions.cycle_history_next,
            ["<C-k>"] = actions.cycle_history_prev,
            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
            ["<CR>"] = actions.select_default + actions.center,
          },
          n = {
            ["<C-n>"] = actions.move_selection_next,
            ["<C-p>"] = actions.move_selection_previous,
            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          },
        },
      },
      extensions = {
        fzy_native = {
          override_generic_sorter = false,
          override_file_sorter = true,
        },
      },
    },
  })
end

function M.find_lunarvim_files(opts)
  opts = opts or {}
  local themes = require "telescope.themes"
  local theme_opts = themes.get_ivy {
    previewer = false,
    sorting_strategy = "ascending",
    layout_strategy = "bottom_pane",
    layout_config = {
      height = 5,
      width = 0.5,
    },
    prompt = ">> ",
    prompt_title = "~ LunarVim files ~",
    cwd = CONFIG_PATH,
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
    cwd = CONFIG_PATH,
  }
  opts = vim.tbl_deep_extend("force", theme_opts, opts)
  require("telescope.builtin").live_grep(opts)
end

function M.setup()
  local telescope = require "telescope"

  telescope.setup(lvim.builtin.telescope.config)
  if lvim.builtin.project.active then
    telescope.load_extension "projects"
  end

  if lvim.builtin.telescope.on_config_done then
    lvim.builtin.telescope.on_config_done(telescope)
  end
end

return M

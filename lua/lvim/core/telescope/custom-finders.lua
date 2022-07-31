local M = {}

local _, builtin = pcall(require, "telescope.builtin")
local _, finders = pcall(require, "telescope.finders")
local _, pickers = pcall(require, "telescope.pickers")
local _, sorters = pcall(require, "telescope.sorters")
local _, themes = pcall(require, "telescope.themes")
local _, actions = pcall(require, "telescope.actions")
local _, previewers = pcall(require, "telescope.previewers")
local _, make_entry = pcall(require, "telescope.make_entry")

local utils = require "lvim.utils"

function M.find_lunarvim_files(opts)
  opts = opts or {}
  local theme_opts = themes.get_ivy {
    sorting_strategy = "ascending",
    layout_strategy = "bottom_pane",
    prompt_prefix = ">> ",
    prompt_title = "~ LunarVim files ~",
    cwd = get_runtime_dir(),
    search_dirs = { utils.join_paths(get_runtime_dir(), "lvim"), lvim.lsp.templates_dir },
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
    search_dirs = { utils.join_paths(get_runtime_dir(), "lvim"), lvim.lsp.templates_dir },
  }
  opts = vim.tbl_deep_extend("force", theme_opts, opts)
  builtin.live_grep(opts)
end

local copy_to_clipboard_action = function(prompt_bufnr)
  local _, action_state = pcall(require, "telescope.actions.state")
  local entry = action_state.get_selected_entry()
  local version = entry.value
  vim.fn.setreg("+", version)
  vim.fn.setreg('"', version)
  vim.notify("Copied " .. version .. " to clipboard", vim.log.levels.INFO)
  actions.close(prompt_bufnr)
end

function M.view_lunarvim_changelog()
  local opts = themes.get_ivy {
    cwd = get_lvim_base_dir(),
  }
  opts.entry_maker = make_entry.gen_from_git_commits(opts)

  pickers
    .new(opts, {
      prompt_title = "~ LunarVim Changelog ~",

      finder = finders.new_oneshot_job(
        vim.tbl_flatten {
          "git",
          "log",
          "--pretty=oneline",
          "--abbrev-commit",
        },
        opts
      ),
      previewer = {
        previewers.git_commit_diff_as_was.new(opts),
      },

      --TODO: consider opening a diff view when pressing enter
      attach_mappings = function(_, map)
        map("i", "<enter>", copy_to_clipboard_action)
        map("n", "<enter>", copy_to_clipboard_action)
        map("i", "<esc>", actions._close)
        map("n", "<esc>", actions._close)
        map("n", "q", actions._close)
        return true
      end,
      sorter = sorters.generic_sorter,
    })
    :find()
end

-- Smartly opens either git_files or find_files, depending on whether the working directory is
-- contained in a Git repo.
function M.find_project_files()
  local ok = pcall(builtin.git_files)

  if not ok then
    builtin.find_files()
  end
end

return M

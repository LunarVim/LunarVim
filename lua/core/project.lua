local M = {}
--
function M.config()
  lvim.builtin.project = {
    --- This is on by default since it's currently the expected behavior.
    ---@usage set to false to disable project.nvim.
    active = true,

    on_config_done = nil,

    -- Manual mode doesn't automatically change your root directory, so you have
    -- the option to manually do so using `:ProjectRoot` command.
    manual_mode = false,

    -- Methods of detecting the root directory. **"lsp"** uses the native neovim
    -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
    -- order matters: if one is not detected, the other is used as fallback. You
    -- can also delete or rearangne the detection methods.
    detection_methods = { "lsp", "pattern" },

    -- All the patterns used to detect root dir, when **"pattern"** is in
    -- detection_methods
    patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },

    -- When set to false, you will get a message when project.nvim changes your
    -- directory.
    silent_chdir = true,
  }
end
--
function M.setup()
  local settings = lvim.builtin.project

  -- Table of lsp clients to ignore by name
  -- eg: { "efm", ... }
  settings["ignore_lsp"] = {}

  -- Path where project.nvim will store the project history for use in
  -- telescope
  settings["datapath"] = CACHE_PATH

  local project = require "project_nvim"

  project.setup(settings)
  lvim.builtin.dashboard.custom_section["b"] = {
    description = { "  Recent Projects    " },
    command = "Telescope projects",
  }

  if lvim.builtin.project.on_config_done then
    lvim.builtin.project.on_config_done(project)
  end
end
--
return M

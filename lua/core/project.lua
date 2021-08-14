local M = {}
function M.config()
  lvim.builtin.project = {
    --- This is on by default since it's currently the expected behavior.
    ---@usage set to false to disable project.nvim.
    active = true,

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
function M.setup()
  require("project_nvim").setup {
    manual_mode = lvim.builtin.project.manual_mode,
    detection_methods = lvim.builtin.project.detection_methods,
    patterns = lvim.builtin.project.patterns,
    silent_chdir = lvim.builtin.project.silent_chdir,

    -- Table of lsp clients to ignore by name
    -- This should probably not be exposed
    -- eg: { "efm", ... }
    ignore_lsp = {},
  }

  lvim.builtin.dashboard.custom_section["b"] = {
    description = { "  Recent Projects    " },
    command = "Telescope projects",
  }

  if package.loaded["telescope"] then
    require('telescope').load_extension('projects')
  end
end
return M

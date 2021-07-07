local M = {}

M.config = function()
  local status_ok, fterm = pcall(require, "FTerm")
  if not status_ok then
    return
  end

  fterm.setup {
    dimensions = {
      height = 0.8,
      width = 0.8,
      x = 0.5,
      y = 0.5,
    },
    border = "single", -- or 'double'
  }

  -- Create LazyGit Terminal
  local term = require "FTerm.terminal"
  local lazy = term:new():setup {
    cmd = "lazygit",
    dimensions = {
      height = 0.9,
      width = 0.9,
      x = 0.5,
      y = 0.3,
    },
  }

  local function is_installed(exe)
    return vim.fn.executable(exe) == 1
  end

  -- Use this to toggle gitui in a floating terminal
  function _G.__fterm_lazygit()
    if is_installed "lazygit" ~= true then
      print "Please install lazygit. Check documentation for more information"
      return
    end
    lazy:toggle()
  end
end

return M

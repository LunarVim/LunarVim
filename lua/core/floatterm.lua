local M = {}
M.config = function()
  O.plugin.floatterm = {
    active = false,
    dimensions = {
      height = 0.9,
      width = 0.9,
      x = 0.5,
      y = 0.3,
    },
    border = "single", -- or 'double'
  }
end

M.setup = function()
  local status_ok, fterm = pcall(require, "FTerm")
  if not status_ok then
    return
  end

  fterm.setup(O.plugin.floatterm)

  -- Create LazyGit Terminal
  local term = require "FTerm.terminal"
  local lazy = term:new():setup {
    cmd = "lazygit",
    dimensions = O.plugin.floatterm.dimensions,
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

  -- Map esc to exit inside lazygit
  --   vim.api.nvim_exec(
  --     [[
  --   function LazyGitNativation()
  --     echom &filetype
  --     if &filetype ==# 'FTerm'
  --       tnoremap <Esc> q
  --       tnoremap <C-v><Esc> <Esc>
  --     endif
  --   endfunction
  --   ]],
  --     false
  --   )

  O.plugin.which_key.mappings["gg"] = "LazyGit"
  vim.api.nvim_set_keymap("n", "<A-i>", "<CMD>lua require('FTerm').toggle()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "<leader>gg", "<CMD>lua _G.__fterm_lazygit()<CR>", { noremap = true, silent = true })

  vim.api.nvim_set_keymap(
    "t",
    "<A-i>",
    "<C-\\><C-n><CMD>lua require('FTerm').toggle()<CR>",
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap("n", "<A-l>", "<CMD>lua _G.__fterm_lazygit()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap(
    "t",
    "<A-l>",
    "<C-\\><C-n><CMD>lua _G.__fterm_lazygit()<CR>",
    { noremap = true, silent = true }
  )
end

return M

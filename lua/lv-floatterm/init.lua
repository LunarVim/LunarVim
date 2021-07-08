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

  function _G.__fterm_command(command)
    if vim.fn.executable(command) ~= 1 then
      print(string.format("Please install %s. Check documentation for more information", command))
      return
    end
    local term = require "FTerm.terminal"
    local lazy = term:new():setup {
      cmd = command,
      dimensions = {
        height = 0.9,
        width = 0.9,
        x = 0.5,
        y = 0.3,
      },
    }
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
  vim.api.nvim_set_keymap("n", "<A-i>", "<CMD>lua require('FTerm').toggle()<CR>", { noremap = true, silent = true })
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

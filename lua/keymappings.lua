local function register_mappings(mappings, default_options)
  for mode, mode_mappings in pairs(mappings) do
    for _, mapping in pairs(mode_mappings) do
      local options = #mapping == 3 and table.remove(mapping) or default_options
      local prefix, cmd = unpack(mapping)
      pcall(vim.api.nvim_set_keymap, mode, prefix, cmd, options)
    end
  end
end

local mappings = {
  n = {
    -- better window movement
    { "<C-h>", "<C-w>h", { silent = true } },
    { "<C-j>", "<C-w>j", { silent = true } },
    { "<C-k>", "<C-w>k", { silent = true } },
    { "<C-l>", "<C-w>l", { silent = true } },

    -- resize with arrows
    { "<C-Up>", ":resize -2<CR>", { silent = true } },
    { "<C-Down>", ":resize +2<CR>", { silent = true } },
    { "<C-Left>", ":vertical resize -2<CR>", { silent = true } },
    { "<C-Right>", ":vertical resize +2<CR>", { silent = true } },

    -- Tab switch buffer
    -- { "<TAB>", ":bnext<CR>" },
    -- { "<S-TAB>", ":bprevious<CR>" },

    -- Move current line / block with Alt-j/k a la vscode.
    { "<A-j>", ":m .+1<CR>==" },
    { "<A-k>", ":m .-2<CR>==" },

    -- QuickFix
    { "]q", ":cnext<CR>" },
    { "[q", ":cprev<CR>" },

    -- {'<C-TAB>', 'compe#complete()', {noremap = true, silent = true, expr = true}},
  },
  v = {
    -- better indenting
    { "<", "<gv" },
    { ">", ">gv" },

    -- { "p", '"0p', { silent = true } },
    -- { "P", '"0P', { silent = true } },
  },
  i = {
    -- I hate escape
    { "jk", "<ESC>" },
    { "kj", "<ESC>" },
    { "jj", "<ESC>" },

    -- Move current line / block with Alt-j/k ala vscode.
    { "<A-j>", "<Esc>:m .+1<CR>==gi" },
    { "<A-k>", "<Esc>:m .-2<CR>==gi" },
  },
  x = {
    -- Move selected line / block of text in visual mode
    { "K", ":move '<-2<CR>gv-gv" },
    { "J", ":move '>+1<CR>gv-gv" },

    -- Move current line / block with Alt-j/k ala vscode.
    { "<A-j>", ":m '>+1<CR>gv-gv" },
    { "<A-k>", ":m '<-2<CR>gv-gv" },
  },
  [""] = {
    -- Toggle the QuickFix window
    { "<C-q>", ":call QuickFixToggle()<CR>" },
  },
}

-- TODO: fix this
if vim.fn.has "mac" == 1 then
  mappings["n"][5][1] = "<A-Up>"
  mappings["n"][6][1] = "<A-Down>"
  mappings["n"][7][1] = "<A-Left>"
  mappings["n"][8][1] = "<A-Right>"
end

register_mappings(mappings, { silent = true, noremap = true })

-- Terminal window navigation
vim.api.nvim_set_keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", { silent = true, noremap = true })
vim.api.nvim_set_keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", { silent = true, noremap = true })
vim.api.nvim_set_keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", { silent = true, noremap = true })
vim.api.nvim_set_keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", { silent = true, noremap = true })
vim.api.nvim_set_keymap("i", "<C-h>", "<C-\\><C-N><C-w>h", { silent = true, noremap = true })
vim.api.nvim_set_keymap("i", "<C-j>", "<C-\\><C-N><C-w>j", { silent = true, noremap = true })
vim.api.nvim_set_keymap("i", "<C-k>", "<C-\\><C-N><C-w>k", { silent = true, noremap = true })
vim.api.nvim_set_keymap("i", "<C-l>", "<C-\\><C-N><C-w>l", { silent = true, noremap = true })

-- Better nav for omnicomplete
vim.cmd 'inoremap <expr> <c-j> ("\\<C-n>")'
vim.cmd 'inoremap <expr> <c-k> ("\\<C-p>")'

-- vim.cmd('inoremap <expr> <TAB> (\"\\<C-n>\")')
-- vim.cmd('inoremap <expr> <S-TAB> (\"\\<C-p>\")')

-- vim.cmd([[
-- map p <Plug>(miniyank-autoput)
-- map P <Plug>(miniyank-autoPut)
-- map <leader>n <Plug>(miniyank-cycle)
-- map <leader>N <Plug>(miniyank-cycleback)
-- ]])

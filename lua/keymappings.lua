vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})
vim.g.mapleader = ' '

-- no hl
vim.api.nvim_set_keymap('n', '<Leader>h', ':set hlsearch!<CR>', {noremap = true, silent = true})

-- explorer
vim.api.nvim_set_keymap('n', '<Leader>e', ':NvimTreeToggle<CR>', {noremap = true, silent = true})

-- better window movement
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {silent = true})
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {silent = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {silent = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {silent = true})

-- Terminal window navigation
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<C-h>', '<C-\\><C-N><C-w>h', {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<C-j>', '<C-\\><C-N><C-w>j', {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<C-k>', '<C-\\><C-N><C-w>k', {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<C-l>', '<C-\\><C-N><C-w>l', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-h>', '<C-\\><C-N><C-w>h', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-j>', '<C-\\><C-N><C-w>j', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-k>', '<C-\\><C-N><C-w>k', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-l>', '<C-\\><C-N><C-w>l', {noremap = true, silent = true})

-- resize with arrows
vim.api.nvim_set_keymap('n', '<C-Up>', ':resize -2<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-Down>', ':resize +2<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-Left>', ':vertical resize -2<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-Right>', ':vertical resize +2<CR>', {noremap = true, silent = true})

-- better indenting
vim.api.nvim_set_keymap('v', '<', '<gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '>', '>gv', {noremap = true, silent = true})

-- I hate escape
vim.api.nvim_set_keymap('i', 'jk', '<ESC>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', 'kj', '<ESC>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', 'jj', '<ESC>', {noremap = true, silent = true})

-- Tab switch buffer
vim.api.nvim_set_keymap('n', '<TAB>', ':bnext<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<S-TAB>', ':bprevious<CR>', {noremap = true, silent = true})

-- Move selected line / block of text in visual mode
vim.api.nvim_set_keymap('x', 'K', ':move \'<-2<CR>gv-gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', 'J', ':move \'>+1<CR>gv-gv', {noremap = true, silent = true})

-- Better nav for omnicomplete
vim.api.nvim_set_keymap('i', '<C-j>', '(\"\\<C-n>\")', {noremap = true, expr = true})
vim.api.nvim_set_keymap('i', '<C-k>', '(\"\\<C-p>\")', {noremap = true, expr = true})
-- vim.cmd('inoremap <expr> <TAB> (\"\\<C-n>\")')
-- vim.cmd('inoremap <expr> <S-TAB> (\"\\<C-p>\")')

-- vim.api.nvim_set_keymap('i', '<C-TAB>', 'compe#complete()', {noremap = true, silent = true, expr = true})

-- vim.cmd([[
-- map p <Plug>(miniyank-autoput)
-- map P <Plug>(miniyank-autoPut)
-- map <leader>n <Plug>(miniyank-cycle)
-- map <leader>N <Plug>(miniyank-cycleback)
-- ]])

-- Helper function
function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', '<Space>', '<NOP>')
vim.g.mapleader = ' '

-- no hl
map('n', '<Leader>h', ':set hlsearch!<CR>')

-- explorer
map('n', '<Leader>e', ':NvimTreeToggle<CR>')


-- better window movement
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- I hate escape
map('i', 'jk', '<ESC>')
map('i', 'kj', '<ESC>')
map('i', 'jj', '<ESC>')

-- Tab switch buffer
map('n', '<TAB>', ':bnext<CR>')
map('n', '<S-TAB>', ':bprevious<CR>')

-- Move selected line / block of text in visual mode
map('x', 'K', ':move \'<-2<CR>gv-gv\'')
map('x', 'J', ':move \'>+1<CR>gv-gv\'')

-- TAB Complete
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})

-- Terminal window navigation
map('t', '<C-h>', '<C-\\><C-N><C-w>h')
map('t', '<C-j>', '<C-\\><C-N><C-w>j')
map('t', '<C-k>', '<C-\\><C-N><C-w>k')
map('t', '<C-l>', '<C-\\><C-N><C-w>l')
map('t', '<Esc>', '<C-\\><C-n>')

-- Window Resizing
map('n', '<C-Up>', ':resize -2<CR>')
map('n', '<C-Down>', ':resize +2<CR>')
map('n', '<C-Left>', ':vertical resize -2<CR>')
map('n', '<C-Right>', ':vertical resize +2<CR>')

-- Better nav for omnicomplete
map('i', '<c-j>', '("\\<C-n>")', {expr = true})
map('i', '<c-k>', '("\\<C-p>")', {expr = true})

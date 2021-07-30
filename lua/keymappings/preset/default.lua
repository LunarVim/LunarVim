local keys = {}

keys.insert_mode = {}
-- I hate escape
keys.insert_mode["jk"] = "<ESC>"
keys.insert_mode["kj"] = "<ESC>"
keys.insert_mode["jj"] = "<ESC>"
-- Move current line / block with Alt-j/k ala vscode.
keys.insert_mode["<A-j>"] = "<Esc>:m .+1<CR>==gi"
keys.insert_mode["<A-k>"] = "<Esc>:m .-2<CR>==gi"
-- navigation
keys.insert_mode["<A-Up>"] = "<C-\\><C-N><C-w>h"
keys.insert_mode["<A-Down>"] = "<C-\\><C-N><C-w>j"
keys.insert_mode["<A-Left>"] = "<C-\\><C-N><C-w>k"
keys.insert_mode["<A-Right>"] = "<C-\\><C-N><C-w>l"
-- navigate tab completion with <c-j> and <c-k>
-- runs conditionally
keys.insert_mode["<C-j>"] = { 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { noremap = true, expr = true } }
keys.insert_mode["<C-k>"] = { 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { noremap = true, expr = true } }

keys.normal_mode = {}
-- Better window movement
keys.normal_mode["<C-h>"] = "<C-w>h"
keys.normal_mode["<C-j>"] = "<C-w>j"
keys.normal_mode["<C-k>"] = "<C-w>k"
keys.normal_mode["<C-l>"] = "<C-w>l"
-- Resize with arrows
keys.normal_mode["<C-Up>"] = ":resize -2<CR>"
keys.normal_mode["<C-Down>"] = ":resize +2<CR>"
keys.normal_mode["<C-Left>"] = ":vertical resize -2<CR>"
keys.normal_mode["<C-Right>"] = ":vertical resize +2<CR>"
if vim.fn.has "mac" == 1 then
  -- TODO: fix this
  keys.normal_mode["<A-Up>"] = ":resize -2<CR>"
  keys.normal_mode["<A-Down>"] = ":resize +2<CR>"
  keys.normal_mode["<A-Left>"] = ":vertical resize -2<CR>"
  keys.normal_mode["<A-Right>"] = ":vertical resize +2<CR>"
end
-- Tab switch buffer
-- keys.normal_mode["<TAB>"] = ":bnext<CR>"
-- keys.normal_mode["<S-TAB>"] = ":bprevious<CR>"
-- Move current line / block with Alt-j/k a la vscode.
keys.normal_mode["<A-j>"] = ":m .+1<CR>=="
keys.normal_mode["<A-k>"] = ":m .-2<CR>=="
-- QuickFix
keys.normal_mode["]q"] = ":cnext<CR>"
keys.normal_mode["[q"] = ":cprev<CR>"
keys.normal_mode["<C-q>"] = ":call QuickFixToggle()<CR>"

keys.term_mode = {}
-- Terminal window navigation
keys.term_mode["<C-h>"] = "<C-\\><C-N><C-w>h"
keys.term_mode["<C-j>"] = "<C-\\><C-N><C-w>j"
keys.term_mode["<C-k>"] = "<C-\\><C-N><C-w>k"
keys.term_mode["<C-l>"] = "<C-\\><C-N><C-w>l"

keys.visual_mode = {}
-- Better indenting
keys.visual_mode["<"] = "<gv"
keys.visual_mode[">"] = ">gv"
-- keys.visual_mode["p"] = { '"0p', { silent = true } }
-- keys.visual_mode["P"] = { '"0p', { silent = true } }

keys.visual_block_mode = {}
-- Move selected line / block of text in visual mode
keys.visual_block_mode["K"] = ":move '<-2<CR>gv-gv"
keys.visual_block_mode["J"] = ":move '>+1<CR>gv-gv"
-- Move current line / block with Alt-j/k ala vscode.
keys.visual_block_mode["<A-j>"] = ":m '>+1<CR>gv-gv"
keys.visual_block_mode["<A-k>"] = ":m '<-2<CR>gv-gv"

return keys

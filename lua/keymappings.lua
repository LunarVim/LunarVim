local lv_utils = require "lv-utils"

local opts = {
  nnoremap = { noremap = true, silent = true },
  inoremap = { noremap = true, silent = true },
  vnoremap = { noremap = true, silent = true },
  xnoremap = { noremap = true, silent = true },
  generic = { silent = true },
}

local default_keys = {
  insert_mode = {
    -- I hate escape
    { "jk", "<ESC>" },
    { "kj", "<ESC>" },
    { "jj", "<ESC>" },
    -- Move current line / block with Alt-j/k ala vscode.
    { "<A-j>", "<Esc>:m .+1<CR>==gi" },
    { "<A-k>", "<Esc>:m .-2<CR>==gi" },
    -- navigation
    { "<A-Up>", "<C-\\><C-N><C-w>h" },
    { "<A-Down>", "<C-\\><C-N><C-w>j" },
    { "<A-Left>", "<C-\\><C-N><C-w>k" },
    { "<A-Right>", "<C-\\><C-N><C-w>l" },
  },

  normal_mode = {
    -- Better window movement
    { "<C-h>", "<C-w>h" },
    { "<C-j>", "<C-w>j" },
    { "<C-k>", "<C-w>k" },
    { "<C-l>", "<C-w>l" },

    -- Resize with arrows
    { "<C-Up>", ":resize -2<CR>" },
    { "<C-Down>", ":resize +2<CR>" },
    { "<C-Left>", ":vertical resize -2<CR>" },
    { "<C-Right>", ":vertical resize +2<CR>" },

    -- Tab switch buffer
    -- { "<TAB>", ":bnext<CR>" },
    -- { "<S-TAB>", ":bprevious<CR>" },

    -- Move current line / block with Alt-j/k a la vscode.
    { "<A-j>", ":m .+1<CR>==" },
    { "<A-k>", ":m .-2<CR>==" },

    -- QuickFix
    { "]q", ":cnext<CR>" },
    { "[q", ":cprev<CR>" },
    { "<C-q>", ":call QuickFixToggle()<CR>" },

    -- {'<C-TAB>', 'compe#complete()', {noremap = true, silent = true, expr = true}},
  },

  term_mode = {
    -- Terminal window navigation
    { "<C-h>", "<C-\\><C-N><C-w>h" },
    { "<C-j>", "<C-\\><C-N><C-w>j" },
    { "<C-k>", "<C-\\><C-N><C-w>k" },
    { "<C-l>", "<C-\\><C-N><C-w>l" },
  },

  visual_mode = {
    -- Better indenting
    { "<", "<gv" },
    { ">", ">gv" },

    -- { "p", '"0p', { silent = true } },
    -- { "P", '"0P', { silent = true } },
  },

  visual_block_mode = {
    -- Move selected line / block of text in visual mode
    { "K", ":move '<-2<CR>gv-gv" },
    { "J", ":move '>+1<CR>gv-gv" },

    -- Move current line / block with Alt-j/k ala vscode.
    { "<A-j>", ":m '>+1<CR>gv-gv" },
    { "<A-k>", ":m '<-2<CR>gv-gv" },
  },
}

if vim.fn.has "mac" == 1 then
  -- TODO: fix this
  default_keys.normal_mode[5][1] = "<A-Up>"
  default_keys.normal_mode[6][1] = "<A-Down>"
  default_keys.normal_mode[7][1] = "<A-Left>"
  default_keys.normal_mode[8][1] = "<A-Right>"
end

if lvim.leader == " " or lvim.leader == "space" then
  vim.g.mapleader = " "
else
  vim.g.mapleader = lvim.leader
end

local function get_user_keys(mode)
  if lvim.keys[mode] == nil then
    return default_keys[mode]
  else
    return lvim.keys[mode]
  end
end

lv_utils.add_keymap_normal_mode(opts.nnoremap, get_user_keys "normal_mode")
lv_utils.add_keymap_insert_mode(opts.inoremap, get_user_keys "insert_mode")
lv_utils.add_keymap_visual_mode(opts.vnoremap, get_user_keys "visual_mode")
lv_utils.add_keymap_visual_block_mode(opts.xnoremap, get_user_keys "visual_block_mode")
lv_utils.add_keymap_term_mode(opts.generic, get_user_keys "term_mode")

-- navigate tab completion with <c-j> and <c-k>
-- runs conditionally
vim.cmd 'inoremap <expr> <C-j> pumvisible() ? "\\<C-n>" : "\\<C-j>"'
vim.cmd 'inoremap <expr> <C-k> pumvisible() ? "\\<C-p>" : "\\<C-k>"'

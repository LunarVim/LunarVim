local keymappings = {}

function keymappings.setup(config)
  local keys = {
    ---@usage change or add keymappings for insert mode
    insert_mode = {
      -- 'jk' for quitting insert mode
      ["jk"] = "<ESC>",
      -- 'kj' for quitting insert mode
      ["kj"] = "<ESC>",
      -- 'jj' for quitting insert mode
      ["jj"] = "<ESC>",
      -- Move current line / block with Alt-j/k ala vscode.
      ["<A-j>"] = "<Esc>:m .+1<CR>==gi",
      -- Move current line / block with Alt-j/k ala vscode.
      ["<A-k>"] = "<Esc>:m .-2<CR>==gi",
      -- navigation
      ["<A-Up>"] = "<C-\\><C-N><C-w>k",
      ["<A-Down>"] = "<C-\\><C-N><C-w>j",
      ["<A-Left>"] = "<C-\\><C-N><C-w>h",
      ["<A-Right>"] = "<C-\\><C-N><C-w>l",
      -- navigate tab completion with <c-j> and <c-k>
      -- runs conditionally
      ["<C-j>"] = { 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true } },
      ["<C-k>"] = { 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true } },
    },

    ---@usage change or add keymappings for normal mode
    normal_mode = {
      -- Better window movement
      ["<C-h>"] = "<C-w>h",
      ["<C-j>"] = "<C-w>j",
      ["<C-k>"] = "<C-w>k",
      ["<C-l>"] = "<C-w>l",

      -- Resize with arrows
      ["<C-Up>"] = ":resize -2<CR>",
      ["<C-Down>"] = ":resize +2<CR>",
      ["<C-Left>"] = ":vertical resize -2<CR>",
      ["<C-Right>"] = ":vertical resize +2<CR>",

      -- Tab switch buffer
      ["<S-l>"] = ":BufferNext<CR>",
      ["<S-h>"] = ":BufferPrevious<CR>",

      -- Move current line / block with Alt-j/k a la vscode.
      ["<A-j>"] = ":m .+1<CR>==",
      ["<A-k>"] = ":m .-2<CR>==",

      -- QuickFix
      ["]q"] = ":cnext<CR>",
      ["[q"] = ":cprev<CR>",
      ["<C-q>"] = ":call QuickFixToggle()<CR>",
    },

    ---@usage change or add keymappings for terminal mode
    term_mode = {
      -- Terminal window navigation
      ["<C-h>"] = "<C-\\><C-N><C-w>h",
      ["<C-j>"] = "<C-\\><C-N><C-w>j",
      ["<C-k>"] = "<C-\\><C-N><C-w>k",
      ["<C-l>"] = "<C-\\><C-N><C-w>l",
    },

    ---@usage change or add keymappings for visual mode
    visual_mode = {
      -- Better indenting
      ["<"] = "<gv",
      [">"] = ">gv",

      -- ["p"] = '"0p',
      -- ["P"] = '"0P',
    },

    ---@usage change or add keymappings for visual block mode
    visual_block_mode = {
      -- Move selected line / block of text in visual mode
      ["K"] = ":move '<-2<CR>gv-gv",
      ["J"] = ":move '>+1<CR>gv-gv",

      -- Move current line / block with Alt-j/k ala vscode.
      ["<A-j>"] = ":m '>+1<CR>gv-gv",
      ["<A-k>"] = ":m '<-2<CR>gv-gv",
    },

    ---@usage change or add keymappings for command mode
    command_mode = {
      -- navigate tab completion with <c-j> and <c-k>
      -- runs conditionally
      ["<C-j>"] = { 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true } },
      ["<C-k>"] = { 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true } },
    },
  }

  if vim.fn.has "mac" == 1 then
    keys.normal_mode["<A-Up>"] = keys.normal_mode["<C-Up>"]
    keys.normal_mode["<A-Down>"] = keys.normal_mode["<C-Down>"]
    keys.normal_mode["<A-Left>"] = keys.normal_mode["<C-Left>"]
    keys.normal_mode["<A-Right>"] = keys.normal_mode["<C-Right>"]

    local Log = require "core.log"
    Log:debug "Activated mac keymappings"
  end

  config:extend(keys)
end

return keymappings

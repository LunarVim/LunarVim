local M = {}

local generic_opts_any = { noremap = true, silent = true }

local mode_adapters = {
  insert_mode = "i",
  normal_mode = "n",
  term_mode = "t",
  visual_mode = "v",
  visual_block_mode = "x",
}

-- Append key mappings to lunarvim's defaults for a given mode
-- @param keymaps The table of key mappings containing a list per mode (normal_mode, insert_mode, ..)
function M.append_to_defaults(keymaps)
  for mode, mappings in pairs(keymaps) do
    for k, v in ipairs(mappings) do
      lvim.keys[mode][k] = v
    end
  end
end

-- Load key mappings for a given mode
-- @param mode The keymap mode, can be one of the keys of mode_adapters
-- @param keymaps The list of key mappings
-- @param opts The mapping options
function M.load_mode(mode, keymaps, opts)
  mode = mode_adapters[mode] and mode_adapters[mode] or mode
  for k, v in pairs(keymaps) do
    vim.api.nvim_set_keymap(mode, k, v, opts)
  end
end

-- Load key mappings for all provided modes
-- @param keymaps A list of key mappings for each mode
-- @param opts The mapping options for each mode
function M.load(keymaps, opts)
  for mode, mapping in pairs(keymaps) do
    M.load_mode(mode, mapping, opts[mode])
  end
end

function M.config()
  lvim.keys = {
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
  }

  if vim.fn.has "mac" == 1 then
    lvim.keys.normal_mode["<A-Up>"] = lvim.keys.normal_mode["<C-Up>"]
    lvim.keys.normal_mode["<A-Down>"] = lvim.keys.normal_mode["<C-Down>"]
    lvim.keys.normal_mode["<A-Left>"] = lvim.keys.normal_mode["<C-Left>"]
    lvim.keys.normal_mode["<A-Right>"] = lvim.keys.normal_mode["<C-Right>"]
  end
end

function M.print(mode)
  print "List of LunarVim's default keymappings (not including which-key)"
  if mode then
    print(vim.inspect(lvim.keys[mode]))
  else
    print(vim.inspect(lvim.keys))
  end
end

function M.setup()
  -- navigate tab completion with <c-j> and <c-k>
  -- runs conditionally
  vim.cmd 'inoremap <expr> <C-j> pumvisible() ? "\\<C-n>" : "\\<C-j>"'
  vim.cmd 'inoremap <expr> <C-k> pumvisible() ? "\\<C-p>" : "\\<C-k>"'
  local generic_opts = {
    insert_mode = generic_opts_any,
    normal_mode = generic_opts_any,
    visual_mode = generic_opts_any,
    visual_block_mode = generic_opts_any,
    term_mode = { silent = true },
  }

  vim.g.mapleader = (lvim.leader == "space" and " ") or lvim.leader
  M.load(lvim.keys, generic_opts)
end

return M

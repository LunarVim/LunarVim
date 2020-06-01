--- Neovim Mappings
-- @module l.mappings

local plug = require("c.plug")
local bind_cmd = require("c.keybind").bind_command
local mode = require("c.edit_mode")
local autocmd = require("c.autocmd")
local util = require("c.util")

local vg = vim.g      -- vim (global) variables table

local layer = {}

--- Returns plugins required for this layer
function layer.register_plugins() --[[ N/A ]] end

--- Configures vim and plugins for this layer
function layer.init_config()

  -- Space for leader
  vg.mapleader = " "
  bind_cmd(mode.NORMAL, "<Space>", "<Nop>", { noremap = true })

  -- Better indenting
  bind_cmd(mode.VISUAL, "<", "<gv" ,{ noremap = true })
  bind_cmd(mode.VISUAL, ">", ">gv" ,{ noremap = true })

  if vg.vscode then
    -- Simulate same TAB behavior in VSCode
    bind_cmd(mode.NORMAL, "<Tab>", ":Tabnext<CR>")
    bind_cmd(mode.NORMAL, "<S-Tab>", ":Tabprev<CR>")

  else
    -- Better nav for omnicomplete
    bind_cmd(mode.INSERT, "<expr> <c-j>", "<C-n>")
    bind_cmd(mode.INSERT, "<expr> <c-k>", "<C-p>")
  
    -- I hate escape more than anything else
    bind_cmd(mode.INSERT, "jk", "<Esc>", { noremap = true })
    bind_cmd(mode.INSERT, "kj", "<Esc>", { noremap = true })
  
    -- Easy CAPS
    -- bind_cmd(mode.INSERT, "<c-u>", "<ESC>viwUi", { noremap = true })
    -- bind_cmd(mode.NORMAL, "<c-u>", "viwUi<ESC>", { noremap = true })
  
    -- TAB in general mode will move to text buffer, SHIFT-TAB will go back
    bind_cmd(mode.NORMAL, "<silent> <TAB>", ":bnext<CR>", { noremap = true })
    bind_cmd(mode.NORMAL, "<silent> <S-TAB>", ":bprevious<CR>", { noremap = true })
  
    -- Alternate ways to save, quit, and escape
    bind_cmd(mode.NORMAL, "<silent> <C-s>", ":w<CR>", { noremap = true })
    bind_cmd(mode.NORMAL, "<silent> <C-Q>", ":wq!<CR>", { noremap = true })
    bind_cmd(mode.NORMAL, "<silent> <C-c>", "<Esc>", { noremap = true })

    -- <TAB>: completion.
    bind_cmd(mode.INSERT, "<silent> <expr><TAB>", "pumvisible() ? '<C-n>' : '<TAB>'", { noremap = true, expr = true })
  
    -- Better window navigation
    bind_cmd(mode.NORMAL, "<C-h>", "<C-w>h")
    bind_cmd(mode.NORMAL, "<C-j>", "<C-w>j")
    bind_cmd(mode.NORMAL, "<C-k>", "<C-w>k")
    bind_cmd(mode.NORMAL, "<C-l>", "<C-w>l")
  
    -- Terminal window navigation
    -- Note: use bracket syntax in binding to allow for backslash in strings
    bind_cmd(mode.TERMINAL, "<Esc>", [[<C-\><C-n>]], { noremap = true })
    bind_cmd(mode.TERMINAL, "<C-h>", [[<C-\><C-N><C-w>h]], { noremap = true })
    bind_cmd(mode.TERMINAL, "<C-j>", [[<C-\><C-N><C-w>j]], { noremap = true })
    bind_cmd(mode.TERMINAL, "<C-k>", [[<C-\><C-N><C-w>k]], { noremap = true })
    bind_cmd(mode.TERMINAL, "<C-l>", [[<C-\><C-N><C-w>l]], { noremap = true })
    bind_cmd(mode.INSERT,   "<C-h>", [[<C-\><C-N><C-w>h]], { noremap = true })
    bind_cmd(mode.INSERT,   "<C-j>", [[<C-\><C-N><C-w>j]], { noremap = true })
    bind_cmd(mode.INSERT,   "<C-k>", [[<C-\><C-N><C-w>k]], { noremap = true })
    bind_cmd(mode.INSERT,   "<C-l>", [[<C-\><C-N><C-w>l]], { noremap = true })
  
    -- Use alt + hjkl to resize windows
    bind_cmd(mode.NORMAL, "<silent> <M-j>", ":resize -2<CR>", { noremap = true })
    bind_cmd(mode.NORMAL, "<silent> <M-k>", ":resize +2<CR>", { noremap = true })
    bind_cmd(mode.NORMAL, "<silent> <M-h>", ":vertical resize -2<CR>", { noremap = true })
    bind_cmd(mode.NORMAL, "<silent> <M-l>", ":vertical resize +2<CR>", { noremap = true })

  end
end

return layer

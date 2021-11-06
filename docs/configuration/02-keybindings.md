# Keybindings

## General Bindings

There are three style options for settings keybindings.

### Vim style

Set bindings with vim.cmd. For more details read `:help vim.cmd`

```lua
# Just take your vim keybindings and wrap them in vim.cmd
vim.cmd("nnoremap W :w<CR>")

# Multiline Statements
vim.cmd([[
    map <Leader>bb :!bundle install<cr>
    map <Leader>gdm :Git diff master<cr>
    imap jj <esc>
]])

# Calling lua functions
vim.cmd("nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>")
```

### Neovim style

Use the `vim.api.nvim_set_keymap` function. Arguments for the function are: (mode, keybind, command, options). For more details read `:help map-arguments`

```lua
vim.api.nvim_set_keymap('n', '<Leader><Space>', ':set hlsearch!<CR>', { noremap = true, silent = true })
-- Vim equivalent
-- :nnoremap <silent> <Leader><Space> :set hlsearch<CR>

vim.api.nvim_set_keymap('n', '<Leader>tegf',  [[<Cmd>lua require('telescope.builtin').git_files()<CR>]], { noremap = true, silent = true })
-- Vim equivalent
-- :nnoremap <silent> <Leader>tegf <Cmd>lua require('telescope.builtin').git_files()<CR>

vim.api.nvim_buf_set_keymap(0, '', 'cc', 'line(".") == 1 ? "cc" : "ggcc"', { noremap = true, expr = true })
-- Vim equivalent
-- :noremap <buffer> <expr> cc line('.') == 1 ? 'cc' : 'ggcc'
```

### LunarVim keybindings

Use `<Leader>Lk` to view the keybindings set by Lunarvim.

To modify a single Lunarvim keymapping

```lua
  -- X closes a buffer
  lvim.keys.normal_mode["<S-x>"] = ":BufferClose<CR>"
```

To remove keymappings set by Lunarvim

```lua
  -- use the default vim behavior for H and L
  lvim.keys.normal_mode["<S-l>"] = nil
  lvim.keys.normal_mode["<S-h>"] = nil
  -- vim.opt.scrolloff = 0 -- Required so L moves to the last line
```

Erase Lunarvim bindings and replace them with your own mappings

```lua
 lvim.keys.normal_mode = {
   -- Page down/up
   ["[d"] = "<PageUp>",
   ["]d"] = "<PageDown>",

   -- Navigate buffers
   ["<Tab>"] = ":bnext<CR>",
   ["<S-Tab>"] = ":bprevious<CR>",
 }
```

### Listing what is mapped

Use `<Leader>Lk` to view the keybindings set by Lunarvim.

To see if a particular key has already been bound:

```lua
:verbose map <TAB>
```

- :nmap for normal mode mappings
- :vmap for visual mode mappings
- :imap for insert mode mappings

Or just list every mapping

```lua
:map
```

To output this to a searchable buffer

```lua
:enew|pu=execute('map')
```

To view keybindings for the nvimtree plugin. Make sure you're in an nvimtree buffer and type `g?` to toggle the keybindings help

## Whichkey Bindings

To add or remap keybindings for whichkey use `lvim.builtin.which_key.mappings`

### Single mapping

Map a single key.

```lua
lvim.builtin.which_key.mappings["P"] = {
  "<cmd>lua require'telescope'.extensions.project.project{}<CR>", "Projects"
}
```

Adding a key to a existing submenu.

```lua
lvim.builtin.which_key.mappings["tP"] = {
  "<cmd>lua require'telescope'.extensions.project.project{}<CR>", "Projects"
}
```

### Submenu mapping

Map a group of keys. `Definitions` would be triggered by pressing `<Leader>td`. The name for this menu would appear as `Trouble`.

```lua
lvim.builtin.which_key.mappings["t"] = {
  name = "Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnosticss" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnosticss" },
}
```

### Replace all whichkey mappings

To clear all whichkey bindings and replace all mappings with your own, use this form.

```lua
lvim.builtin.which_key.mappings = {
  ["c"] = { "<cmd>BufferClose!<CR>", "Close Buffer" },
  ["e"] = { "<cmd>lua require'core.nvimtree'.toggle_tree()<CR>", "Explorer" },
  ["h"] = { '<cmd>let @/=""<CR>', "No Highlight" },

  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    r = { "<cmd>lua require('lv-utils').reload_lv_config()<cr>", "Reload" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },
}
```

### Example mappings

Consult the [LunarVim configuration for whichkey](https://github.com/LunarVim/LunarVim/blob/rolling/lua/core/which-key.lua) to see more examples of how to map keys.

## Leader Key

The default leader key is `Space`. This can be changed with the following

```lua
lvim.leader = "space"
```

## Cursor Movement

By default, when pressing left/right cursor keys, Vim will not move to the previous/next line after reaching first/last character in the line. This can be quite annoying for new users. Fortunately this behaviour can be easily changed by putting this in your vimrc file:

To enable:

```lua
lvim.line_wrap_cursor_movement = true
```

Enabling maps the following command

```vim
set whichwrap+=<,>,h,l,[,]
```

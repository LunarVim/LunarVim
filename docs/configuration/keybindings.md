# Keybindings

## General Bindings
There are three style options for settings keybindings.  
### Vim style
Set bindings with vim.cmd.  For more details read `:help vim.cmd`

```
# Just take your vim keybindings and wrap them in vim.cmd
vim.cmd("nnoremap W :w<CR>")

# Multiline Statements
vim.cmd([[
map <Leader>bb :!bundle install<cr>
map <Leader>gdm :Git diff master<cr>
imap jj <esc>
]])

# Calling lua functions
vim.cmd("vim.cmd("nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>")")
```
### Neovim style
Use the `vim.api.nvim_set_keymap` function. Arguments for the function are: (mode, keybind, command, options).  For more details read `:help map-arguments`

```
vim.api.nvim_set_keymap('n', '<Leader><Space>', ':set hlsearch!<CR>', { noremap = true, silent = true })
-- :nnoremap <silent> <Leader><Space> :set hlsearch<CR>
vim.api.nvim_set_keymap('n', '<Leader>tegf',  [[<Cmd>lua require('telescope.builtin').git_files()<CR>]], { noremap = true, silent = true })
-- :nnoremap <silent> <Leader>tegf <Cmd>lua require('telescope.builtin').git_files()<CR>

vim.api.nvim_buf_set_keymap(0, '', 'cc', 'line(".") == 1 ? "cc" : "ggcc"', { noremap = true, expr = true })
-- :noremap <buffer> <expr> cc line('.') == 1 ? 'cc' : 'ggcc'
```

### LunarVim style
Define a table of mappings
```
 lvim.keys.normal_mode = {
-- Page down/up
   {'[d', '<PageUp>'},
   {']d', '<PageDown>'},

-- Navigate buffers
   {'<Tab>', ':bnext<CR>'},
   {'<S-Tab>', ':bprevious<CR>'},
 }
 ```

 Or use the utility functions 
 * add_keymap_insert_mode
 * add_keymap_normal_mode
 * add_keymap_term_mode
 * add_keymap_visual_block_mode
 * add_keymap_visual_mode

 ```
 require("utils").add_keymap_insert_mode({ silent = true }, {
 { "<C-s>", ":w<cr>" },
 { "<C-c>", "<ESC>" },
 })
 ```

### Listing what is mapped
To see if a key has already been bound:
```
:verbose map <TAB>
```
* :nmap for normal mode mappings
* :vmap for visual mode mappings
* :imap for insert mode mappings

Or just list every mapping
```
:map
```

To output this to a searchable buffer
```
:enew|pu=execute('map')
```

## Whichkey Bindings
To add or remap keybindings for whichkey use `lvim.builtin.which_key.mappings`

### Single mapping
Map a single key.
```
lvim.builtin.which_key.mappings["P"] = { "<cmd>lua require'telescope'.extensions.project.project{}<CR>", "Projects" }
```

### Submenu mapping
Map a group of keys.  `Definitions` would be triggerd by pressing `<Leader>td`. The name for this menu would appear as `Trouble`.
```
lvim.builtin.which_key.mappings["t"] = {
--   name = "Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnosticss" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnosticss" },
-- }
```

To clear all whichkey bindings and replace all mappings with your own, use this form.
```
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

# Keybindings

Use `<Leader>Lk` to view the keybindings set by Lunarvim.

To modify a single Lunarvim keymapping

```lua
  -- X closes a buffer
  lvim.keys.normal_mode["<S-x>"] = ":BufferClose<CR>"
```

To remove keymappings set by Lunarvim

```lua
  lvim.keys.normal_mode["<C-h>"] = false
  lvim.keys.normal_mode["<C-j>"] = false
  lvim.keys.normal_mode["<C-k>"] = false
  lvim.keys.normal_mode["<C-l>"] = false
```

### Listing what is mapped

Use `<Leader>Vk` to view the keybindings set by Lunarvim.

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

## Explorer Bindings

To view keybindings for the nvimtree plugin. Make sure you're in an nvimtree buffer and type `g?` to toggle the keybindings help

## LSP Bindings

TODO

lvim.lsp.buffer_mappings.normal_mode

## Whichkey Bindings

To add or remap keybindings for whichkey use `lvim.builtin.which_key.mappings`

### Single mapping

Map a single key.

```lua
lvim.builtin.which_key.mappings["P"] = {
  "<cmd>lua require'telescope'.extensions.project.project{}<CR>", "Projects"
}
```

### Removing a single mapping

Remove a single Whichkey keybind
```lua
lvim.builtin.which_key.mappings['w'] = {}
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
  d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
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
<iframe width="560" height="315" src="https://www.youtube.com/embed/BdoizYjJHis" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen="1"></iframe>

## Leader Key

The default leader key is `Space`. This can be changed with the following

```lua
lvim.leader = "space"
```

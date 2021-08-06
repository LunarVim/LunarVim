# Recommended Keybindings

## Python

```lua
lvim.autocommands.custom_groups = {
  {
    "Filetype",
    "python",
    "nnoremap <leader>r <cmd>lua require('core.terminal')._exec_toggle('python " .. vim.fn.expand "%" .. ";read')<CR>",
  },
  {
    "Filetype",
    "python",
    "nnoremap <leader>t <cmd>lua require('toggleterm.terminal').Terminal:new {cmd='python -m unittest;read', hidden =false}:toggle()<CR>",
  },
}
lvim.builtin.which_key.mappings["r"] = "Run"
lvim.builtin.which_key.mappings["t"] = "Test"
```

### Django

```lua
lvim.builtin.terminal.execs = {
  { "lazygit", "gg", "LazyGit" },
  { "python manage.py test;read", "jt", "Django tests" },
  { "python manage.py makemigrations;read", "jm", "Django makemigrations" },
  { "python manage.py migrate;read", "ji", "Django migrate" },
}
```

# Updating LunarVim

Update your plugins, LunarVim and `neovim`:

### Plugins

In `lvim`:
```vim
:PackerUpdate
```

### LunarVim

```bash
cd ~/.local/share/lunarvim/lvim && git pull
```
Then, in `lvim`:
```vim
:PackerSync
```

### Neovim

Use your package manager or [compile from source](./dev/#compiling-neovim-from-source).

---
sidebar: auto
---

# FAQ

## How do I [..] ?

### How do I add my own keybindings?

- View all defaults by pressing `<leader>Lk`
- change the leader key

```lua
lvim.leader = "space"
```

- Add your own binding

```lua
-- save the buffer
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- move the cursor without leaving insert mode
lvim.keys.insert_mode["<A-h>"] = "<Left>"
lvim.keys.insert_mode["<A-l>"] = "<Right>"
```

- Remove or un-map a default binding

```lua
-- disable completely
lvim.keys.normal_mode["<C-Up>"] = ""
-- define a new behavior
lvim.keys.normal_mode["<C-q>"] = ":q<cr>"
```

- You can also use the NeoVim API directly using [nvim_set_keymap](<https://neovim.io/doc/user/api.html#nvim_set_keymap()>)

```lua
vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()", { noremap = true, silent = true, expr = true })
```

- Or you can use the native vim way for those tricky bindings that you are not sure how to translate just yet

```lua
-- Search and replace word under cursor using <F2>
vim.cmd [[ nnoremap <F2> :%s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/i ]]
```

## What is `null-ls` and why do you use it?

For C/C++ we have the `clangd` by `llvm` which can also use its siblings' abilities `clang-tidy` and `clang-format` to support additional linting and formatting. But something like `pyright` doesn't support formatting, so we use `null-ls` to register `black` and `flake8` for example, as a "fake" language server.

Since it's not using a separate binary it's called `null-ls` or _null language server_.

## Where can I find some example configs?

If you want ideas for configuring LunarVim you can look at these repositories.

- Chris - [https://github.com/ChristianChiarulli/lvim](https://github.com/ChristianChiarulli/lvim)
- Abouzar -[ https://github.com/abzcoding/lvim ](https://github.com/abzcoding/lvim)
- Nelson -[ https://github.com/rebuilt/lvim ](https://github.com/rebuilt/lvim)

---
sidebar: auto
---

# FAQ

## How do I [..] ?

### How do I add my own keybindings?

- change the leader key

```lua
lvim.leader = "space"
```

- overwrite the key-mappings provided by LunarVim for any mode, or leave it empty to keep them

```lua
lvim.keys.normal_mode = {
  {'<Tab>', ':bnext<CR>'},
  {'<S-Tab>', ':bprevious<CR>'},
}
```

- if you just want to augment the existing ones then use the utility function

```lua
require("utils").add_keymap_insert_mode({ silent = true }, {
  { "<C-s>", ":w<cr>" },
  { "<C-c>", "<ESC>" },
  })
```
- you can also use the native vim way directly

```lua
vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()", { noremap = true, silent = true, expr = true })
```

## What is `null-ls` and why do you use it?

For C/C++ we have the `clangd` by `llvm` which can also use its siblings' abilities `clang-tidy` and `clang-format` to support additional linting and formatting. But something like `pyright` doesn't support formatting, so we use `null-ls` to register `black` and `flake8` for example, as a "fake" language server. 

Since it's not using a separate binary it's called `null-ls` or _null language server_.

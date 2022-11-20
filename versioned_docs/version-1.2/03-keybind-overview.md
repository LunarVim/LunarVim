# Keybind overview

Here's an overview of the most commonly used mappings.
It is not a complete list, you can find more by pressing `<leader>sk` to search through them,
or `<leader>` to show whichkey (keybinds popup)

Also see:
[vim mappings](https://devhints.io/vim)

**TIP:** `<leader>` is space by default, read `:help keycodes` for more key names

**TIP:** `<M>` is `alt` on Windows/Linux and `option` on MacOS

## Plugins

| key                 | description                                                                              | mode   |
| ------------------- | ---------------------------------------------------------------------------------------- | ------ |
| `<leader>`          | [whichkey](https://github.com/folke/which-key.nvim) (keybinds popup (shows up after 1s)) | normal |
| `<leader>e`         | [nvimtree](https://github.com/nvim-tree/nvim-tree.lua) (side file explorer)              | normal |
| `<leader>f`         | [telesope](https://github.com/nvim-telescope/telescope.nvim) (find files)                | normal |
| `<leader>;`         | [alpha](https://github.com/goolord/alpha-nvim) (dashboard)                               | normal |
| `<C-\>` `<M-1/2/3>` | [toggleterm](https://github.com/akinsho/toggleterm.nvim) (terminal)                      | normal |

## LSP

| key  | description           | mode   |
| ---- | --------------------- | ------ |
| `K`  | hover information     | normal |
| `gd` | go to definition      | normal |
| `gD` | go to declaration     | normal |
| `gr` | go to references      | normal |
| `gI` | go to implementation  | normal |
| `gs` | show signature help   | normal |
| `gl` | show line diagnostics | normal |

## Editing

| key         | description       | mode           |
| ----------- | ----------------- | -------------- |
| `<leader>/` | comment           | normal, visual |
| `gb`        | block comment     | visual         |
| `<A-k>`     | move line(s) up   | normal, visual |
| `<A-j>`     | move line(s) down | normal, visual |

## Completion

| key                        | description                            | mode   |
| -------------------------- | -------------------------------------- | ------ |
| `<C-space>`                | show completion menu                   | insert |
| `<CR>` `<C-y>`             | confirm                                | insert |
| `<C-e>`                    | abort                                  | insert |
| `<C-k>` `<Up>` `<Tab>`     | select previous item                   | insert |
| `<C-j>` `<Down>` `<S-Tab>` | select next item                       | insert |
| `<C-d>`                    | scroll docs up                         | insert |
| `<C-f>`                    | scroll docs down                       | insert |
| `<CR>` `<Tab>`             | jump to next jumpable in a snippet     | insert |
| `<S-Tab>`                  | jump to previous jumpable in a snippet | insert |

## Windows

| key         | description            | mode   |
| ----------- | ---------------------- | ------ |
| `<C-h>`     | go to left window      | normal |
| `<C-j>`     | go to lower window     | normal |
| `<C-k>`     | go to upper window     | normal |
| `<C-l>`     | go to right window     | normal |
| `<C-Up>`    | decrease window height | normal |
| `<C-Down>`  | increase window height | normal |
| `<C-Left>`  | decrease window width  | normal |
| `<C-Right>` | increase window width  | normal |

## Miscellaneous

| key          | description               | mode   |
| ------------ | ------------------------- | ------ |
| `<leader>Lc` | edit config.lua           | normal |
| `<leader>h`  | clear search highlighting | normal |
| `<leader>sh` | search through `:help`    | normal |

## [nvimtree](https://github.com/nvim-tree/nvim-tree.lua) (side file explorer)

`g?` show keybidings

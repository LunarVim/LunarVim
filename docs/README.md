<img :src="$withBase('/assets/lunarvim_logo.png')" alt="LunarVim Logo">

---

# Introduction

LunarVim is an IDE layer for Neovim. Taking advantage of new advancements such as Treesitter and the Language Server Protocol, LunarVim is opinionated, extensible and fast.

## Opinionated

LunarVim ships with a sane default config to build on top of. Features include autocompletion, integrated terminal, file explorer, fuzzy finder, LSP, linting, formatting and debugging.

## Extensible

Just because LunarVim has an opinion doesn't mean you have to share it. Every builtin plugin enabled by default can be disabled in the `config.lua` file. Here you can also add your own plugins, keymaps, autocommands, leader bindings and any other custom configuration.

## Fast

LunarVim lazyloads plugins wherever possible to maximize speed. Disabled plugins also will not decrease speed due to the plugin list being compiled with only the active plugins. This strategy allows LunarVim to not have to choose between features and speed.

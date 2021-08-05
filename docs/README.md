<img :src="$withBase('/assets/lunarvim_logo.png')" alt="LunarVim Logo">

---

# Introduction

LunarVim is an IDE layer for Neovim >= 0.5.0. Taking advantage of new advancements in Lua scripting such as [Treesitter](https://tree-sitter.github.io/tree-sitter/) and the [Language Server Protocol](https://en.wikipedia.org/wiki/Language_Server_Protocol), LunarVim is opinionated, extensible and fast.

## Opinionated

LunarVim ships with a sane default config to build on top of. Features include autocompletion, integrated terminal, file explorer, fuzzy finder, LSP, linting, formatting and debugging.

## Extensible

Just because LunarVim has an opinion doesn't mean you need to share it. Every builtin plugin can be toggled on or off in the `config.lua` file. This is the place to add your own plugins, keymaps, autocommands, leader bindings and all other custom settings.

## Fast

LunarVim lazyloads plugins wherever possible to maximize speed. Disabled plugins also will not decrease speed due to the plugin list being compiled with only the active plugins. This strategy allows LunarVim to not have to choose between features and speed.

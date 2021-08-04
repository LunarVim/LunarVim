# Learning Lua

To get started, [this guide](https://github.com/nanotee/nvim-lua-guide) covers many points that will get you going with Lua and how Neovim works.

## Official Documentation

The [reference manual](https://www.lua.org/manual/5.4/) is the official definition of the Lua language.

If you don't know about it, [DevDocs](https://devdocs.io/lua~5.4/) combines multiple API documentations in a fast, organized, and searchable interface.

## Neovim Documentation

Neovim provides a [standard library](https://neovim.io/doc/user/lua.html) which you should know about.

It provides many functions that you wish were implemented in Lua's stdlib, for instance `strings.split`.

It also comes with a [LSP framework](https://neovim.io/doc/user/lsp.html) and [much more](https://neovim.io/doc/user/).

## Style Guide

LuaRock [style guide](https://github.com/luarocks/lua-style-guide) is a complete work that deserves a look if you want learn how to write consistent and robust code.

It is based on many pre-existing guides, provides rationals for all their decisions, and worked successfully in a long-running project.

## Code Quality

To ensure code quality and a consistent style, our [CI](https://github.com/ChristianChiarulli/LunarVim/actions) uses the following tools:

- Lua:
  - [Stylua](https://github.com/JohnnyMorganz/StyLua). An opinionated Lua code formatter.
  - [Luacheck](https://github.com/mpeterv/luacheck). A tool for linting and static analysis of Lua code. 
- Shell
  - [Shfmt](https://github.com/mvdan/sh). A shell parser, formatter, and interpreter with bash support.
  - [Shellcheck](https://github.com/koalaman/shellcheck). A static analysis tool for shell scripts.

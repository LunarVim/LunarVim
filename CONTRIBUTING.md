# Contributing to LunarVim

Welcome to the LunarVim contributing guide. We are excited about the prospect of you joining our [community](https://github.com/lunarvim/LunarVim/graphs/contributors)!

There are many opportunities to contributing to the project at any level. Every contribution is highly valued and no contribution is too small.

You do not need to write code to contribute to this project. Documentation, demos, and feature design advancements are a key part of this project's growth.

One of the best ways to begin contributing in a meaningful way is by helping find bugs and filing issues for them.

## Getting Started

1. Backup your ~/.config/nvim
2. Follow the [Installation](https://github.com/lunarvim/LunarVim/wiki/Installation) guide
3. Link your fork with the repository `git remote add upstream https://github.com/lunarvim/LunarVim.git`
4. That's it ! You can now `git fetch upstream` and `git rebase [-i] upstream/rolling` to update your branches with the latest contributions.

## Setting up development tools

### For editing Lua files

1. Formatter: [stylua](https://github.com/johnnymorganz/stylua#installation).
2. Linter:  [luacheck](https://github.com/luarocks/luacheck).

### For editing shell scripts

1. Formatter: [shfmt](https://github.com/mvdan/sh#shfmt).
2. Linter: [shellcheck](https://github.com/koalaman/shellcheck).

### (Optional)

Install [pre-commit](https://github.com/pre-commit/pre-commit) which will run all linters and formatters for you as a pre-commit-hook.

## Some Guidelines

### Git Commit Messages

* Use the present tense ("Add feature" not "Added feature")
* Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
* Limit the first line to 72 characters or less
* Reference issues and pull requests liberally after the first line

### Git Branch Naming

* Name your branches meaningfully,
ex: (feature|bugfix|hotfix)/what-my-pr-does

### Code 

All lua code is formatted with [Stylua](https://github.com/JohnnyMorganz/StyLua).
* Use snake_case
* Avoid platform-dependent code
```bash
stylua --config-path ./utils/.stylua.toml -c .
```

All shell code is formatted according to [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html)
* use two spaces instead of tabs
```bash
shfmt -i 2 -ci -l -d .
```


## Communication

Members of the community have multiple ways to collaborate on the project.
We encourage you to join the community:
- [Discord server](https://discord.gg/Xb9B4Ny)
- [Matrix server](https://matrix.to/#/#atmachine-neovim:matrix.org)

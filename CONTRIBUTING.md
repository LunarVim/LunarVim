# Contributing to LunarVim

Welcome to the LunarVim contributing guide. We are excited about the prospect of you joining our [community](https://github.com/lunarvim/LunarVim/graphs/contributors)!

There are many opportunities to contributing to the project at any level. Every contribution is highly valued and no contribution is too small.

You do not need to write code to contribute to this project. Documentation, demos, and feature design advancements are a key part of this project's growth.

One of the best ways to begin contributing in a meaningful way is by helping find bugs and filing issues for them.

## Getting Started

1. Follow the [Installation](https://www.lunarvim.org/01-installing.html) guide
2. Link your fork with the repository `git remote add upstream https://github.com/lunarvim/LunarVim.git`, or use `gh fork`
3. That's it! You can now `git fetch upstream` and `git rebase [-i] upstream/rolling` to update your branches with the latest contributions.

<br />

## Setting up development tools

### For editing Lua files

1. Formatter: [stylua](https://github.com/johnnymorganz/stylua#installation).
2. Linter:  [luacheck](https://github.com/luarocks/luacheck).

### For editing shell scripts

1. Formatter: [shfmt](https://github.com/mvdan/sh#shfmt).
2. Linter: [shellcheck](https://github.com/koalaman/shellcheck).

### (Optional)

Install [pre-commit](https://github.com/pre-commit/pre-commit) which will run all linters and formatters for you as a pre-commit-hook.

<br />

## Code Conventions

All lua code is formatted with [Stylua](https://github.com/JohnnyMorganz/StyLua).
```bash
# configurations are already stored in .stylua.toml
stylua -c .
```

All shell code is formatted according to [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html)
* use two spaces instead of tabs
```bash
shfmt -i 2 -ci -bn -l -d .
```

<br />

## Pull Requests (PRs)

- To avoid duplicate work, create a draft pull request.
- Your PR must pass all the [automated-ci-tests](https://github.com/neovim/neovim/actions).
- Use a [git-feature-branch](https://www.atlassian.com/git/tutorials/comparing-workflows) instead of the master/rolling branch.
- Use a [rebase-workflow](http://git-scm.com/book/en/v2/Git-Branching-Rebasing).

### Commit Messages
* Commit header is limited to 72 characters.
* Commit body and footer is limited to 100 characters per line.

**Commit header format:**
```
<type>(<scope>?): <summary>
  │       │           │
  │       │           └─> Present tense.     'add something...'(O) vs 'added something...'(X)
  │       │               Imperative mood.   'move cursor to...'(O) vs 'moves cursor to...'(X)
  │       │               Not capitalized.
  │       │               No period at the end.
  │       │
  │       └─> Commit Scope is optional, but strongly recommended.
  │           Use lower case.
  │           'plugin', 'file', or 'directory' name is suggested, but not limited.
  │
  └─> Commit Type: build|ci|docs|feat|fix|perf|refactor|test
```

##### Commit Type Guideline

* **build**: changes that affect the build system or external dependencies (example scopes: npm, pip, rg)
* **ci**: changes to CI configuration files and scripts (example scopes: format, lint, issue_templates)
* **docs**: changes to the documentation only
* **feat**: new feature for the user
* **fix**: bug fix
* **perf**: performance improvement
* **refactor**: code change that neither fixes a bug nor adds a feature
* **test**: adding missing tests or correcting existing tests
* **chore**: all the rest, including version bump for plugins

**Real world examples:**
```
feat(quickfix): add 'q' binding to quit quickfix window when focused
```
```
fix(installer): add missing "HOME" variable
```


### Branch Naming

Name your branches meaningfully.

ex)
```(feature|bugfix|hotfix)/what-my-pr-does```

<br />

## Communication

Members of the community have multiple ways to collaborate on the project.
We encourage you to join the community:
- [Discord server](https://discord.gg/Xb9B4Ny)
- [Matrix server](https://matrix.to/#/#atmachine-neovim:matrix.org)

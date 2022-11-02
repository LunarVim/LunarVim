# Ruby

### Install Syntax Highlighting

```vim
:TSInstall ruby
```

## Supported language servers

```lua
{ "ruby_ls", "solargraph", "sorbet" }
```

### Solargraph

Project root is recognized by having one of the following files/folders in the root directory of the project: `Gemfile`, `.git`.

Note: `Solargraph` should automatically detect and use `rubocop` for formatting.

## Supported formatters

```lua
{ "rubocop", "rufo", "standardrb" }
```

## Supported linters

```lua
{ "rubocop", "semgrep", "standardrb" }
```

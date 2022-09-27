# Ruby

### Install Syntax Highlighting

```vim
:TSInstall ruby
```

## Supported language servers

```lua
ruby = { "solargraph" }
```

### Solargraph

Project root is recognized by having one of the following files/folders in the root directory of the project: `Gemfile`, `.git`.

Note: `Solargraph` should automatically detect and use `rubocop` for formatting.

## Supported formatters

```lua
ruby = { "rubocop", "rufo", "standardrb" }
```

## Supported linters

```lua
ruby = { "rubocop", "standardrb" }
```

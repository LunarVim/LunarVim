# Ruby

### Install Syntax Highlighting

```vim
:TSInstall ruby
```

## Supported language servers

- ruby_ls
- solargraph
- sorbet

### Solargraph

Project root is recognized by having one of the following files/folders in the root directory of the project: `Gemfile`, `.git`.

Note: `Solargraph` should automatically detect and use `rubocop` for formatting.

## Supported formatters

- rubocop
- rufo
- standardrb

## Supported linters

- rubocop
- semgrep
- standardrb

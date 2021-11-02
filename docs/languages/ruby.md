# Ruby

## Solargraph

### Install Syntax Highlighting
```vim
:TSInstall ruby
```

### Install Language Server
```vim
:LspInstall solargraph
```
Project root is recognized by having one of the following files/folders in the root directory of the project: `Gemfile` , `.git`. 

### Formatting

Solargraph should automatically detect and use `rubocop` for formatting.  To enable format on save add the following to your config
```lua
lvim.format_on_save = true
```

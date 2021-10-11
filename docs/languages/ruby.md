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

### Older versions of LunarVim

Prior to commit d01ba08, the above did not work.  If you have a commit older than d01ba08, the recommended way to install the language server for ruby is to do it locally, per project by either including it in your Gemfile or `gem install solargraph`.  

`LspInstall solargraph` works for basic cases but will fail silently for more complex projects.  This was an [issue](https://github.com/LunarVim/LunarVim/issues/945) with older builds of LunarVim

Also add the following to your `config.lua`

```lua
local util = require("lspconfig/util")
lvim.lang.ruby.lsp.setup = {
    cmd = { "solargraph", "stdio" },
    filetypes = { "ruby" },
    init_options = {
      formatting = true
    },
    root_dir = util.root_pattern("Gemfile", ".git"),
    settings = {
      solargraph = {
        diagnostics = true
      }
    }
}
```

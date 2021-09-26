# Ruby

## Solargraph

The recommended way to install the language server for ruby is to do it locally, per project by either including it in your Gemfile or `gem install solargraph`.  

`LspInstall ruby` works for basic cases but will fail silently for more complex projects.  This is a known [issue](https://github.com/LunarVim/LunarVim/issues/945)

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

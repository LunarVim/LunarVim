# Scala

## Install Syntax Highlighting
 
```vim
:TSInstall scala
```
The support for Scala 3 like syntax is limited.

## Install Language Server

To get scala LSP support working in Lunarvim, first you need to do the prerequisites listed [here](https://github.com/scalameta/nvim-metals#prerequisites) 

Then use coursier to install the metals language server so that it is available on your PATH:

`coursier install metals`

Also, you can install the scala formatter

`coursier install scalafmt`

## Configure Lunarvim

Create a file called `~/.config/lvim/lua/user/metals.lua`:

```lua
local M = {}

M.config = function()
  local metals_config = require("metals").bare_config()
  metals_config.on_attach = require("lvim.lsp").common_on_attach
  metals_config.settings = {
    showImplicitArguments = false,
    showInferredType = true,
    excludedPackages = {},
  }
  metals_config.init_options.statusBarProvider = false
  require("metals").initialize_or_attach { metals_config }
end

return M
```

Add the following to your `config.lua`

```lua
lvim.plugins = {
    {
      "scalameta/nvim-metals",
      config = function()
        require("user.metals").config()
      end,
    },
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.scala", "*.sbt", "*.sc" },
  callback = function() require('user.metals').config() end,
})
```
When you open the first scala file, you should run `:MetalsInstall` in order to complete the plugin installation.

## Supported formatters

In most cases, isn't necessary enable the [scalafmt](https://scalameta.org/scalafmt/) formatter, this is already integrated with metals to format on save creating a `.scalafmt.conf` file in your project root, see more [here](https://scalameta.org/scalafmt/docs/configuration.html)

```lua
scala = { "scalafmt" }
```

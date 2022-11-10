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
  local lvim_lsp = require("lvim.lsp")
  local metals_config = require("metals").bare_config()
  metals_config.on_init = lvim_lsp.common_on_init
  metals_config.on_exit = lvim_lsp.common_on_exit
  metals_config.capabilities = lvim_lsp.common_capabilities()
  metals_config.on_attach = function(client, bufnr)
    lvim_lsp.common_on_attach(client, bufnr)
    require("metals").setup_dap()
  end
  metals_config.settings = {
    superMethodLensesEnabled = true,
    showImplicitArguments = true,
    showInferredType = true,
    showImplicitConversionsAndClasses = true,
    excludedPackages = {},
  }
  metals_config.init_options.statusBarProvider = false
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "scala", "sbt", "java" },
    callback = function() require("metals").initialize_or_attach(metals_config) end,
    group = vim.api.nvim_create_augroup("nvim-metals", { clear = true }),
  })
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

dap.configurations.scala = {
  {
    type = "scala",
    request = "launch",
    name = "Run or Test Target",
    metals = {
      runType = "runOrTestFile",
    },
  },
  {
    type = "scala",
    request = "launch",
    name = "Test Target",
    metals = {
      runType = "testTarget",
    },
  },
}
```

When you open the first scala file, you should run `:MetalsInstall` in order to complete the plugin installation.

To debug scala program, make sure that dap is activated:

```
lvim.builtin.dap.active = true
```

Any Lunarvim builtin debug commands, which could be displayed by pressing `<leader> d`, is supported.

## Supported formatters

In most cases, isn't necessary enable the [scalafmt](https://scalameta.org/scalafmt/) formatter, this is already integrated with metals to format on save creating a `.scalafmt.conf` file in your project root, see more [here](https://scalameta.org/scalafmt/docs/configuration.html)

- scalafmt

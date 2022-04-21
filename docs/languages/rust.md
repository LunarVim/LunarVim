# Rust

## Install Syntax Highlighting

```vim
:TSInstall rust
```

## Supported language servers

```lua
rust = { "rust_analyzer" }
```

## Supported formatters

```lua
rust = { "rustfmt" }
```

## LSP Settings

```vim
:LspSettings rust_analyzer
```

## Debugger

```vim
:DIInstall codelldb
```

```lua
-- ~/.config/lvim/ftplugin/rust.lua
local dap_install = require "dap-install"
dap_install.config("codelldb", {})
```

## Extra Plugins

```lua
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })

lvim.plugins = {
  {
    "simrat39/rust-tools.nvim",
    config = function()
      local lsp_installer_servers = require "nvim-lsp-installer.servers"
      local _, requested_server = lsp_installer_servers.get_server "rust_analyzer"
      require("rust-tools").setup({
        tools = {
          autoSetHints = true,
          hover_with_actions = true,
          runnables = {
            use_telescope = true,
          },
        },
        server = {
          cmd_env = requested_server._default_options.cmd_env,
          on_attach = require("lvim.lsp").common_on_attach,
          on_init = require("lvim.lsp").common_on_init,
        },
        })
    end,
    ft = { "rust", "rs" },
  },
}
```

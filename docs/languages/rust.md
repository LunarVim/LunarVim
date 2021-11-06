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
:NlspConfig rust_analyzer
```

## Debugger

```vim
:DIInstall ccppr_lldb
```

```lua
-- ~/.config/lvim/ftplugin/rust.lua
local dap_install = require "dap-install"
dap_install.config("rust", {})
```

## Extra Plugins

```lua
lvim.lsp.override = { "rust" }
lvim.plugins = {
  {
    "simrat39/rust-tools.nvim",
    config = function()
      require("rust-tools").setup({
        tools = {
          autoSetHints = true,
          hover_with_actions = true,
          runnables = {
            use_telescope = true,
          },
        },
        server = {
          cmd = { vim.fn.stdpath "data" .. "/lsp_servers/rust/rust-analyzer" },
          on_attach = require("lvim.lsp").common_on_attach,
          on_init = require("lvim.lsp").common_on_init,
        },
        })
    end,
    ft = { "rust", "rs" },
  },
}
```

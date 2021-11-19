# C/C++

## Install Syntax Highlighting

```vim
:TSInstall c
```

```vim
:TSInstall cpp
```

## Install Language Server

You can install `clangd` language server using the [nvim-lsp-installer](https://github.com/williamboman/nvim-lsp-installer)

```vim
:LspInstall clangd
```

Check the official documentation for other methods <https://clangd.llvm.org/installation>.

## Formatters

`clangd` language server supports formatting using `clang_format` by default. Optionally, you can use `uncrustify` or `clang-format` directly if you don't want to use `clangd`.

Configuration in `~/.config/lvim/config.lua`

```lua
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup { { exe = "uncrustify", args = {} } }
```

The selected formatter must be installed separately.

## LSP Settings

If you need specific settings for `clangd` then you can override it like this

```lua
-- check the full default list `:lua print(vim.inspect(lvim.lsp.override))`
vim.list_extend(lvim.lsp.override, { "clangd" })
```

Now you can customize the setup completely

```lua
-- some settings can only passed as commandline flags `clangd --help`
local clangd_flags = {
  "--all-scopes-completion",
  "--suggest-missing-includes",
  "--background-index",
  "--pch-storage=disk",
  "--cross-file-rename",
  "--log=info",
  "--completion-style=detailed",
  "--enable-config", -- clangd 11+ supports reading from .clangd configuration file
  "--clang-tidy",
  -- "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type",
  -- "--fallback-style=Google",
  -- "--header-insertion=never",
  -- "--query-driver=<list-of-white-listed-complers>"
}

local clangd_bin = "clangd"

local custom_on_attach = function(client, bufnr)
  require("lvim.lsp").common_on_attach(client, bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lh", "<Cmd>ClangdSwitchSourceHeader<CR>", opts)
end

local opts = {
  cmd = { clangd_bin, unpack(clangd_flags) },
  on_attach = custom_on_attach,
}

require("lvim.lsp.manager").setup("clangd", opts)
```

Refer to the official documentation if you face any issues <https://clangd.llvm.org/troubleshooting>.

## Debugger

```vim
:DIInstall ccppr_vsc
```

To enable pretty-printing, create a custom configuration:

```lua
-- ~/.config/lvim/ftplugin/cpp.lua
local dap_install = require "dap-install"
dap_install.config("ccppr_vsc", {
  adapters = {
    type = "executable",
  },
  configurations = {
    {
      type = "cpptools",
      request = "launch",
      name = "Launch with pretty-print",
      program = function()
        return vim.fn.input('Path to exe: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = true,
      setupCommands = {
        {
          description = "Enable pretty-printing",
          text = "-enable-pretty-printing",
        }
      }
    },
  }
})

```

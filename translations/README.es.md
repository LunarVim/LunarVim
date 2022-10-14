![lunarvim_logo_dark](https://user-images.githubusercontent.com/59826753/159940098-54284f26-f1da-4481-8b03-1deb34c57533.png)

<div align="center"><p>
    <a href="https://github.com/lunarvim/LunarVim/releases/latest">
      <img alt="Latest release" src="https://img.shields.io/github/v/release/lunarvim/LunarVim" />
    </a>
    <a href="https://github.com/lunarvim/LunarVim/pulse">
      <img alt="Last commit" src="https://img.shields.io/github/last-commit/lunarvim/LunarVim"/>
    </a>
    <a href="https://github.com/lunarvim/LunarVim/blob/main/LICENSE">
      <img src="https://img.shields.io/github/license/lunarvim/lunarvim?style=flat-square&logo=GNU&label=License" alt="License"
    />
    <a href="https://patreon.com/chrisatmachine" title="Donate to this project using Patreon">
      <img src="https://img.shields.io/badge/patreon-donate-yellow.svg" alt="Patreon donate button" />
    </a>
    <a href="https://twitter.com/intent/follow?screen_name=chrisatmachine">
      <img src="https://img.shields.io/twitter/follow/chrisatmachine?style=social&logo=twitter" alt="follow on Twitter">
    </a>
</p>

</div>

## Demostración
![intro1](https://user-images.githubusercontent.com/29136904/191624232-a7b13f11-cc9f-495e-879e-67ea0444c568.png)
![info](https://user-images.githubusercontent.com/29136904/191624942-3d75ef87-35cf-434d-850e-3e7cd5ce2ad0.png)

![demo1](https://user-images.githubusercontent.com/29136904/191625579-ce9efb1f-1e23-4a05-aebc-915a0f614d72.png)
![demo2](https://user-images.githubusercontent.com/29136904/191626018-2e9ee682-043c-4ce5-a5dd-c11b94759782.png)
![demo3](https://user-images.githubusercontent.com/29136904/191626246-ce0cc0c5-4b41-49e3-9cb7-4b1867ab0dcb.png)

## Instala con un solo Comando!

Asegúrate de tener la última versión de Neovim (0.8+).

### Linux/MacOS:

Si tienes la versión 0.8+ de Neovim

```bash
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
```

Si tienes la versión 0.8+ de Neovim

```bash
export LV_BRANCH="rolling"; bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/rolling/utils/installer/install.sh)
```

Para correr el script de instalación sin ninguna interacción puedes pasar el argumento `-y` para installar automáticamente todas las dependencias y no tener mensajes. Esto es particularmente útil en instalaciones automatizadas.

De la misma manera, puedes usar `--no-install-dependencies` para saltar la instalación de dependencias.

### Windows (Powershell 7+):

Powershell v7+ es requerido para este script. Para instrucciones de cómo installar, [da clic aquí.](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-7.2)

```powershell
Invoke-WebRequest https://raw.githubusercontent.com/LunarVim/LunarVim/master/utils/installer/install.ps1 -UseBasicParsing | Invoke-Expression
```

## Soporte automático de LSP

Por defecto, la mayoría de los servidores de lenguages serán instalados automáticamente una vez hayas abierto un tipo de archivo soportado, por ejemplo: abrir un archivo Python por primera vez intalará `Pyright` y se configurará automáticamente.

## Archivo de configuración

Para instalar plugins y/o configurar LunarVim, utiliza `config.lua` ubicado aquí: `~/.config/lvim/config.lua`

Ejemplo:

```lua
-- general
lvim.format_on_save = true
lvim.colorscheme = "tokyonight"

lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = ""
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"
-- set keymap with custom opts
-- lvim.keys.insert_mode["po"] = {'<ESC>', { noremap = true }}

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- Configure builtin plugins
lvim.builtin.alpha.active = true
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true

-- Treesitter parsers change this to a table of the languages you want i.e. {"java", "python", javascript}
lvim.builtin.treesitter.ensure_installed = "all"
lvim.builtin.treesitter.ignore_install = { "haskell" }

-- Disable virtual text
lvim.lsp.diagnostics.virtual_text = false

-- Select which servers should be configured manually. Requires `:LvimCacheReset` to take effect.
-- See the full default list `:lua print(vim.inspect(lvim.lsp.override))`
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })

-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black" },
  {
    command = "prettier",
    ---@usage specify which filetypes to enable. By default, providers will attach to all the filetypes it supports.
    filetypes = { "typescript", "typescriptreact" },
  },
}

-- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  {
    command = "eslint_d",
    ---@usage specify which filetypes to enable. By default, providers will attach to all the filetypes it supports.
    filetypes = { "javascript", "javascriptreact" },
  },
}

-- Additional Plugins
lvim.plugins = {
    {"lunarvim/colorschemes"},
    {
        "ray-x/lsp_signature.nvim",
        config = function() require"lsp_signature".on_attach() end,
        event = "BufRead"
    }
}
```

## Actualizar LunarVim

- Dentro de LunarVim: `:LvimUpdate`
- Desde la terminal: `lvim +LvimUpdate +q`

### Actualizar los plugins

- Dentro de LunarVim `:PackerUpdate`

## Recursos

- [Documentation](https://www.lunarvim.org)

- [YouTube](https://www.youtube.com/channel/UCS97tchJDq17Qms3cux8wcA)

- [Discord](https://discord.gg/Xb9B4Ny)

- [Twitter](https://twitter.com/chrisatmachine)

## Testimonios

> "Tengo el poder de procesamiento de una patata con 4 gb de ram y LunarVim corre perfectamente"

> - @juanCortelezzi, usuario de LunarVim.

> "Mi configuración mínima con menor cantidad de código que LunarVim carga 40ms más lento. Hora de cambiar"

> - @mvllow, Posible usuario de LunarVim.

<div align="center" id="madewithlua">

[![Lua](https://img.shields.io/badge/Made%20with%20Lua-blue.svg?style=for-the-badge&logo=lua)](#madewithlua)

</div>

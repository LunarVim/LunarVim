![LunarVim Demo](./utils/media/lunarvim_logo_dark.png)

<div align="center"><p>
    <a href="https://github.com/ChristianChiarulli/LunarVim/releases/latest">
      <img alt="Latest release" src="https://img.shields.io/github/v/release/ChristianChiarulli/LunarVim" />
    </a>
    <a href="https://github.com/ChristianChiarulli/LunarVim/pulse">
      <img alt="Last commit" src="https://img.shields.io/github/last-commit/ChristianChiarulli/LunarVim"/>
    </a>
    <a href="https://github.com/ChristianChiarulli/LunarVim/blob/main/LICENSE">
      <img src="https://img.shields.io/github/license/siduck76/NvChad?style=flat-square&logo=GNU&label=License" alt="License"
    />
    <a href="https://patreon.com/chrisatmachine" title="Donate to this project using Patreon">
      <img src="https://img.shields.io/badge/patreon-donate-yellow.svg" alt="Patreon donate button" />
    </a>
    <a href="https://twitter.com/intent/follow?screen_name=chrisatmachine">
      <img src="https://img.shields.io/twitter/follow/chrisatmachine?style=social&logo=twitter" alt="follow on Twitter">
    </a>
</p>	

</div>

## Install In One Command!

Make sure you have the newest version of Neovim (0.5).

``` bash
bash <(curl -s https://raw.githubusercontent.com/ChristianChiarulli/lunarvim/master/utils/installer/install.sh)
```

If you help to develop Lunarvim, you can install a specific branch branch directly
``` bash
LVBRANCH=rolling bash <(curl -s https://raw.githubusercontent.com/ChristianChiarulli/lunarvim/rolling/utils/installer/install.sh)
```

If your installation is stuck on `Ok to remove? [y/N]`, it means there are some leftovers, \
you can run the script with `--overwrite` but be warned this will remove the following folder:
- `~/.config/nvim`
- `~/.cache/nvim`
- `~/.local/share/nvim/site/pack/packer`
```bash
curl -s https://raw.githubusercontent.com/ChristianChiarulli/lunarvim/rolling/utils/installer/install.sh| LVBRANCH=rolling bash -s -- --overwrite
```


## Installing LSP for your language

Just enter `:LspInstall` followed by `<TAB>` to see your options

**NOTE** I recommend installing `lua` for autocomplete in `lv-config.lua`

## Configuration file

To activate other plugins and language features use the `lv-config.lua` file provided in the `nvim` folder (`~/.config/nvim/lv-config.lua`)

Example:

```lua
-- O is the global options object

-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
-- general
-- O.default_options.wrap = true -- wrap long lines
O.completion.autocomplete = true
O.default_options.relativenumber = true
O.colorscheme = 'spacegray'
O.default_options.timeoutlen = 100
O.leader_key = ' '

-- After changing plugin config it is recommended to run :PackerCompile
O.plugin.dashboard.active = true
O.plugin.floatterm.active = true
O.plugin.zen.active = true

-- if you don't want all the parsers change this to a table of the ones you want
O.treesitter.ensure_installed = "all"
O.treesitter.ignore_install = {"haskell"}
O.treesitter.highlight.enabled = true

-- lua
O.lang.lua.autoformat = false
O.lang.lua.formatter = 'lua-format'

-- javascript
O.lang.tsserver.formatter = 'prettier'
O.lang.tsserver.linter = nil
O.lang.tsserver.autoformat = true

-- python
O.lang.python.isort = true
O.lang.python.diagnostics.virtual_text = true
O.lang.python.analysis.use_library_code_types = true
-- to change default formatter from yapf to black
-- O.lang.python.formatter.exe = "black"
-- O.lang.python.formatter.args = {"-"}

-- go
-- to change default formatter from gofmt to goimports
-- O.lang.formatter.go.exe = "goimports"

-- Additional Plugins
-- O.user_plugins = {
--   {"folke/tokyonight.nvim"},
--   {
--     "ray-x/lsp_signature.nvim",
--     config = function()
--       require"lsp_signature".on_attach()
--     end,
--     event = "InsertEnter"
--   },
-- }

-- }

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- O.user_autocommands = {{ "BufWinEnter", "*", "echo \"hi again\""}}

-- Additional Leader bindings for WhichKey
-- O.user_which_key = {
--   A = {
--     name = "+Custom Leader Keys",
--     a = { "<cmd>echo 'first custom command'<cr>", "Description for a" },
--     b = { "<cmd>echo 'second custom command'<cr>", "Description for b" },
--   },
-- }

-- To link your init.vim (until you find Lua replacements)
-- vim.cmd('source ' .. CONFIG_PATH .. '/lua/lv-user/init.vim')
```

## Updating LunarVim

In order to update you should be aware of three things `Plugins`, `LunarVim` and `Neovim`

To update plugins:

```
:PackerUpdate
```

To update LunarVim:

```bash
cd ~/.config/nvim && git pull
```

To update Neovim use your package manager

## Project Goals

1. Provide basic functionalities required from an IDE
    - LSP
    - Formatting/Linting
    - Debugging
    - Treesitter
    - Colorschemes
2. Be as fast and lean as possible 
    - Lazy loading
    - Not a single extra plugin
    - User configurable lang/feature enable/disable
3. Provide a [simple and easy](https://github.com/LunarVim/LunarVimCommunity) way for users to share their own configuration or use others. 
4. Hot reload of configurations
    - Hot install of lsp/treesitter/formatter required upon openning a filetype for the first time
5. Provide a stable & maintainable error free configuration layer over neovim 
    - With the help of the community behind it
    - Github workflow testing
    - Freezing plugin versions
6. Provide detailed documentation
    - Video series on how to configure LunarVim as an IDE for each lang
7. Valhalla

## Resources

- [YouTube](https://www.youtube.com/channel/UCS97tchJDq17Qms3cux8wcA)

- [Wiki](https://github.com/ChristianChiarulli/LunarVim/wiki)

- [Discord](https://discord.gg/Xb9B4Ny)

- [Twitter](https://twitter.com/chrisatmachine)

## Testimonials

> "I have the processing power of a potato with 4 gb of ram and LunarVim runs perfectly."
> - @juanCortelezzi, LunarVim user.

> "My minimal config with a good amount less code than LunarVim loads 40ms slower. Time to switch."
> - @mvllow, Potential LunarVim user.

<div align="center" id="madewithlua">
	
[![Lua](https://img.shields.io/badge/Made%20with%20Lua-blue.svg?style=for-the-badge&logo=lua)](#madewithlua)
	
</div>

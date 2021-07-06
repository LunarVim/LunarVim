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
bash <(curl -s https://raw.githubusercontent.com/ChristianChiarulli/lunarvim/stable/utils/installer/install.sh)
```

## Installing LSP for your language

Just enter `:LspInstall` followed by `<TAB>` to see your options

**NOTE** I recommend installing `lua` language support to make work

## Configuration file

To activate other plugins and language features use the `lv-config.lua` file provided in the `nvim` folder (`~/.config/nvim/lv-config.lua`)

Example:

```lua
-- O is the global options object

-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
-- general
O.auto_complete = true
O.colorscheme = 'spacegray'
O.leader_key = ' '
O.relative_number = false
O.timeoutlen = 100

-- After changing plugin config it is recommended to run :PackerCompile
O.plugin.colorizer.active = true
O.plugin.trouble.active = true
O.plugin.zen.active = true

-- if you don't want all the parsers change this to a table of the ones you want
O.treesitter.ensure_installed = "all"
O.treesitter.highlight.enabled = true
O.treesitter.ignore_install = {"haskell"}

-- lua
O.lang.lua.autoformat = false
O.lang.lua.formatter = 'lua-format'

-- javascript
O.lang.tsserver.autoformat = true
O.lang.tsserver.formatter = 'prettier'
O.lang.tsserver.linter = nil

-- json
O.lang.json.autoformat = true
```

**NOTE** After changing a setting it is important to exit LunarVim and run the following:

```
:PackerInstall

:PackerCompile
```

## Updating LunarVim

In order to update you should be aware of three things `Plugins`, `LunarVim` and `Neovim`

To update plugins:

```
:PackerUpdate
```

To update LunarVim:

```
cd ~/.config/nvim && git pull
```

## Resources

- [YouTube](https://www.youtube.com/channel/UCS97tchJDq17Qms3cux8wcA)

- [Wiki](https://github.com/ChristianChiarulli/LunarVim/wiki)

- [Discord](https://discord.gg/Xb9B4Ny)

- [Twitter](https://twitter.com/chrisatmachine)

## Testimonials

> "I have the processing power of a potato with 4 gb of ram and LunarVim runs perfectly."
> - @juanCortelezzi, LunarVim user.

<div align="center">
	
[![Lua](https://img.shields.io/badge/Made%20with%20Lua-blue.svg?style=for-the-badge&logo=lua)]()
	
	
</div>

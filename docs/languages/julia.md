# Julia

## Install Syntax Highlighting

```vim
:TSInstall julia
```

## Install Language Server

The Juila language server, LanguageServer.jl, needs to be manually installed.
To install LanguageServer.jl in the location where [nvim-lspconfig
expects](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#julials)
run the following terminal command:

```bash
julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer")'
```

Create the file `~/.config/lvim/ftplugin/julia.lua` with the following line to
start the language server when opening Julia files.

```lua
require('lspconfig').julials.setup{}
```

## Supporting Plugins

For Latex-to-Unicode substitutions, block-wise movements, and other niceties for
writing Julia, install the [julia-vim
](https://github.com/JuliaEditorSupport/julia-vim) plugin.

## Pro Tip

To leverage the
[edit](https://docs.julialang.org/en/v1/stdlib/InteractiveUtils/#InteractiveUtils.edit-Tuple{Any})
functionality with LunarVim use the
[define_editor](https://docs.julialang.org/en/v1/stdlib/InteractiveUtils/#InteractiveUtils.define_editor)
method in `~/.julia/config/startup.jl`

```julia
using InteractiveUtils

ENV["JULIA_EDITOR"] = "lvim"

InteractiveUtils.define_editor(
    r"lvim", wait=true) do cmd, path, line
    `$cmd +$line $path`
end
```

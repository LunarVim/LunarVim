# Julia

Julia support has been added to LunarVim but the LspInstall project does not yet have an installer for it.  You cannot ':LspInstall julia'

To install the Julia language server in the location where [nvim-lspconfig expects](https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#julials):
* run the following terminal command:

```
julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer")'
```

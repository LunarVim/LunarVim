# Julia

Julia support has been added to LunarVim but the LspInstall project does not yet have an installer for it.  You cannot ':LspInstall julia'

To install the Julia language server:
* Create a file with the following code (install.jl):

```
using Pkg;
Pkg.add("LanguageServer")
Pkg.add("SymbolServer")
Pkg.instantiate()
```
* Run the file you created

```
julia install.jl
```

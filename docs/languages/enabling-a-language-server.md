# Enabling language servers

Neovim comes bundled with a language client but not a language server.
To install a supported language server:

``` md
  :LspInstall `<your_language_server>`
```

Autocomplete works here.  Type `:LspInstall`, then hit `TAB` to see supported language servers

See [LspInstall](https://github.com/kabouzeid/nvim-lspinstall) for more
info.

In order for Java LSP to work, edit `~/.local/share/nvim/lspinstall/java/jdtls.sh` and replace `WORKSPACE="$1"` with `WORKSPACE="$HOME/workspace"`

Most common languages should be supported out of the box, if yours is
not I would welcome a PR

### Julia support

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

## LSP errors

LunarVim lists the attached lsp server in the bottom status bar. If it
says ‘No client connected’ use :LspInfo to troubleshoot.

### Understanding LspInfo

1.  Make sure there is a client attached to the buffer. 0 attached
    clients means lsp is not running
2.  Active clients are clients in other files you have open
3.  Clients that match the filetype will be listed. If installed with
    :LspInstall `<servername>` the language servers will be installed.  
4.  ‘cmd’ must be populated. This is the language server executable. If
    the ‘cmd’ isn’t set or if it’s not executable you won’t be able to
    run the language server.  
    * In the example below ‘efm-langserver’ is the name of the binary
    that acts as the langserver. If we run ‘which efm-langserver’ and we
    get a location to the executable, it means the langauge server is
    installed and available globally. 
    * If you know the command is installed AND you don’t want to install 
    it globally you’ll need to manually set 'cmd' in the language server 
    settings. 
    * Configurations are stored in ~/.config/nvim/lua/lsp/ 
    The settings will be stored in a file that matches the name of the language.
    e.g. python-ls.lua 
    * ‘identified root’ must also be populated. Most
    language servers require you be inside a git repository for the root
    to be detected. If you don’t want to initialize the directory as a
    git repository, an empty .git/ folder will also work.  
5.  Some language servers get set up on a per project basis so you may
    have to reinstall the language server when you move to a different
    project.

### Example configurations

[ ========  LSP NOT running  ======== ]

``` md
0 client(s) attached to this buffer:

0 active client(s):

Clients that match the filetype python:

  Config: efm
    cmd:               /Users/my-user/.local/share/nvim/lspinstall/efm/efm-langserver
    cmd is executable: True
    identified root:   None
    custom handlers:

  Config: pyright
    cmd:               /Users/my-user/.local/share/nvim/lspinstall/python/node_modules/.bin/pyright-langserver --stdio
    cmd is executable: True
    identified root:   None
    custom handlers:   textDocument/publishDiagnostics
```

---

[ ========  LSP IS running  ======== ]

``` md
2 client(s) attached to this buffer: pyright, efm

  Client: pyright (id 1)
  	root:      /home/my-user/workspace/canary
  	filetypes: python
  	cmd:       /home/my-user/.local/share/nvim/lspinstall/python/node_modules/.bin/pyright-langserver --stdio


  Client: efm (id 2)
  	root:      /home/my-user/workspace/canary
  	filetypes: lua, python, javascriptreact, javascript, typescript, typescriptreact, sh, html, css, json, yaml, markdown, vue
  	cmd:       /home/my-user/.local/share/nvim/lspinstall/efm/efm-langserver
```

### Last resort

If you still have problems after implementing the above measures, rule
out plugin problems with the following. This reinstalls your plugins and
language servers.

``` md
rm -rf ~/.local/share/lunarvim/site
rm -rf ~/.local/share/nvim/lspinstall
# Open neovim and run the following
:PackerSync
:LspInstall python   `<-- REPLACE WITH YOUR OWN LANGUAGE`
:LspInstall efm      `<-- REPLACE WITH YOUR OWN LANGUAGE`
```

For a more in depth LSP support:
[link](https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md)

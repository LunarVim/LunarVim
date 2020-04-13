# Nvim

Plugging my [blog](chrisatmachine.com)
Plugging my [YouTube channel](https://www.youtube.com/channel/UCS97tchJDq17Qms3cux8wcA)

## Install 

Dependencies:

- neovim
- Node
- Python3
- Ripgrep
- fzf
- ranger
- hack-nerd-font
- ranger
- universal-ctags

### Install dependencies On MacOS

```
brew install node
brew install neovim
brew install ripgrep
brew install fzf
brew tap homebrew/cask-fonts
brew cask install font-hack-nerd-font
brew install ranger
brew install --HEAD universal-ctags/universal-ctags/universal-ctags
```

### Install dependencies on Linux

I assume you can figure it out based on the requirements smart guy

### Setting Node path and Python3 path

#### pythonpath

Create `modules/pythonpath.vim` and point it to a version of python that has neovim installed

example:

```
let g:python3_host_prog = expand("~/.miniconda/envs/neovim/bin/python3.8")
```

#### nodepath for Coc

Create `modules/nodepath.vim` and point it to a version of python that has neovim installed

example:

```
let g:coc_node_path = expand("~/.nvm/versions/node/v12.16.1/bin/node")
let g:node_host_prog = expand("~/.nvm/versions/node/v12.16.1/bin/node")
```

## Set up plugin manager

```
sh ~/.config/nvim/utils/installer.sh ~/.config/nvim/dein
```

## Install packages

You should now run `nvim` and wait while the package manager installs your plugins


## Post install

After install open Neovim and run the following:

```
:UpdateRemotePlugins

:checkhealth
```

## CoC Language support


You may need to do this if CoC says it can't find Javascript:

```
cd ~/.cache/dein/repos/github.com/neoclide/coc.nvim
git clean -xfd
yarn install --frozen-lockfile
```

[Official installation page](https://github.com/neoclide/coc.nvim/wiki/Install-coc.nvim)
[CoC Extensions](https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions)

## ALE Linting

## Markdown Preview

I had to cd into `dein/repos/github.com/iamcco/markdown-preview.nvim/`

and run 'npx yarn install'

## TODO 

- make better use of ftplugin
- Document node nonsense in order to install coc
- configure coc settings better 
- need formatter for other languages
- set up ale
- Java support for Lombock, figured it out on work machine
- Need support for image in current ranger implementation
- https://github.com/kevinhwang91/rnvimr (Note Ueberzug doesn't work on mac which sucks, also neither does this plugin)
- Check out more coc extensions
- https://github.com/voldikss/coc-todolist
- VimWiki
- coc explorer and coc floating terminal are pretty cool
- look into save vim sessions
- create keymap file and move combinations from general
- ultisnips for autogenerate front matter with data and stuff
- setup blog with vimwiki
- vimwiki hijacks my TAB complete in md files so I'm disabling [link to issue](https://github.com/vimwiki/vimwiki/issues/353)
- vimwiki also hijacks conceal level 

## Notes

install ripgrep" for gutentags to ignore .gitignore
If you get an error like this: `gutentags: ctags job failed, returned:` remove the tags directory in `~/.cache`

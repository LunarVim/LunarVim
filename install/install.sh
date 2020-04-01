#!/bin/sh

if [ "$(uname)" == "Darwin" ]; then
    echo 'MacOS Detected'
    echo "installing miniconda"
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -O ~/.config/nvim/install/miniconda.sh
    echo " Grabbing a font to use foe devicons "
    brew tap homebrew/cask-fonts
    brew cask install font-hack-nerd-font
    brew install ranger
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    echo 'Linux Detected'
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/.config/nvim/install/miniconda.sh
    mkdir -p ~/.local/share/fonts
    cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
fi

#chmod +x ~/.config/nvim/install/miniconda.sh

sh ~/.config/nvim/install/miniconda.sh -b -f -p  $HOME/.miniconda

echo '# Miniconda' >> ~/.zshrc
echo 'export PATH="$HOME/.miniconda/bin:$PATH"' >> ~/.zshrc

. ~/.zshrc

conda create --name neovim python=3.8 --yes

. activate neovim 

pip install neovim

. deactivate

#conda create --name pyls python=3.7 --yes

#. activate pyls

#pip install 'python-language-server[all]'
#pip install vim-vint

#. deactivate

#pip install 'python-language-server[all]'

#if [ ! -f ~/.bash_aliases ]; then
#    echo ".bash_aliases not found!"
#    touch ~/.bash_aliases
#    echo 'source ~/.bash_aliases' >> ~/.bashrc
#fi

#echo 'alias mkenv="conda create --clone pyls --name"' >> ~/.bash_aliases

echo 'let g:python3_host_prog = expand("~/.miniconda/envs/neovim/bin/python3.8")' > ~/.config/nvim/modules/pythonpath.vim     

if [ ! -d ~/.config/nvim/dein ]; then
    echo "dein  package manager not found"
    sh ~/.config/nvim/install/utils/installer.sh ~/.config/nvim/dein
fi

# Cleanup

rm ~/.config/nvim/install/miniconda.sh

#!/bin/bash

set -o nounset    # error when referencing undefined variable
set -o errexit    # exit when command fails


installnode() { \
    echo "installing node..."
    curl -sL install-node.now.sh/lts | bash
    npm i -g neovim
}

installpip() { \
    echo "installing pip..."
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python3 get-pip.py
    rm get-pip.py
}

installpynvim() { \
    echo "installing pynvim..."
    pip install pynvim
}

cloneconfig() { \
    echo "cloning Nvim Mach 2 configuration"
    git clone https://github.com/ChristianChiarulli/nvim.git ~/.config/nvim
}

moveoldnvim() { \
    echo "moving your config to nvim.old"
    mv $HOME/.config/nvim $HOME/.config/nvim.old
}

installplugins() { \
    "Installing plugins..."
    nvim --headless +PlugInstall +qall > /dev/null 2>&1
}

# Welcome
echo 'Installing Nvim Mach 2'

# install node and neovim support
which node > /dev/null && echo "node installed, moving on..." || installnode

# install pip
which pip > /dev/null && echo "pip installed, moving on..." || installpynvim

# install pynvim
pip list | grep pynvim > /dev/null && echo "pynvim installed, moving on..." || installpynvim

# pull config down
[ -d "$HOME/.config/nvim" ] && moveoldnvim 

cloneconfig

# install plugins
which neovim > /dev/null && installplugins

# Install extensions
mkdir -p ~/.config/coc/extensions
cd ~/.config/coc/extensions
if [ ! -f package.json ]
then
  echo '{"dependencies":{}}'> package.json
fi
# Change extension names to the extensions you need
npm install coc-explorer coc-snippets coc-json --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod

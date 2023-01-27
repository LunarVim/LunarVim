# install win32yank.exe for clipboard sharing (FOR WSL)
curl -sLo/tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
chmod +x /tmp/win32yank.exe
sudo mv /tmp/win32yank.exe /usr/local/bin/

# download anonymice font
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/AnonymousPro/complete/Anonymice%20Nerd%20Font%20Complete%20Mono.ttf $HOME/Downloads/

# install neovim from source and dependencies
wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.deb
sudo apt install -y \
  ./nvim-linux64.deb \
  ripgrep
rm nvim-linux64.deb

# install lvim
bash <(curl -s https://raw.githubusercontent.com/f1lem0n/lunarvim/master/utils/installer/install.sh)

# add executable to path
echo "PATH=/home/f1lem0n/.local/bin:$PATH" >> $HOME/.bashrc

echo "You are almost done..."
echo "Do not forget to set your terminal font as Anonymice (which is in your ~/Downloads) or another nerd-font."

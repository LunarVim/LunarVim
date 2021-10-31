#!/bin/sh
USER_BIN_DIR="$HOME/.local/bin"
if [ -d "/data/data/com.termux" ]; then
  sudo() {
    eval "$@"
  }
  USER_BIN_DIR="$HOME/../usr/bin"
fi
rm -rf ~/.local/share/lunarvim
sudo rm "$USER_BIN_DIR"/lvim
rm -rf ~/.local/share/applications/lvim.desktop

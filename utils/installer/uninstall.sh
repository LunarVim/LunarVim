#!/bin/sh
if [ -d "/data/data/com.termux" ]; then
	sudo() {
		eval "$@"
	}
	bin_path="$HOME/../usr/bin"
else
	bin_path='/usr/local/bin'
fi
rm -rf ~/.local/share/lunarvim
sudo rm $bin_path/lvim
rm -rf ~/.local/share/applications/lvim.desktop

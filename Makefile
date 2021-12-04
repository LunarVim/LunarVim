SHELL := /bin/bash

install:
	@echo Starting LunarVim Installer
	bash ./utils/installer/install.sh

install-neovim-binary:
	@echo Installing Neovim from github releases
	bash ./utils/installer/install-neovim-from-release

uninstall:
	@echo Starting LunarVim Uninstaller
	bash ./utils/installer/uninstall.sh

generate_plugins_sha:
	@echo generating core-plugins latest SHA list
	lvim --headless -c 'lua require("lvim.utils").generate_plugins_sha("latest-sha.lua")' -c 'qall'

lint: lint-lua lint-sh

lint-lua:
	luacheck *.lua lua/* tests/*

lint-sh:
	shfmt -f . | grep -v jdtls | xargs shellcheck

style: style-lua style-sh

style-lua:
	stylua --config-path .stylua.toml --check .

style-sh:
	shfmt -f . | grep -v jdtls | xargs shfmt -i 2 -ci -l -d

test:
	bash ./utils/bin/test_runner.sh "$(TEST)"

.PHONY: install install-neovim-binary uninstall lint style test

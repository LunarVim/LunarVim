SHELL := /usr/bin/env bash

install:
	@echo starting LunarVim installer
	bash ./utils/installer/install.sh

install-bin:
	@echo starting LunarVim bin-installer
	bash ./utils/installer/install_bin.sh

install-neovim-binary:
	@echo installing Neovim from github releases
	bash ./utils/installer/install-neovim-from-release

uninstall:
	@echo starting LunarVim uninstaller
	bash ./utils/installer/uninstall.sh

generate_plugins_sha:
	@echo generating core-plugins latest SHA list
	lvim --headless -c 'lua require("lvim.utils.git").generate_plugins_sha("latest-sha.lua")' -c 'qall'

lint: lint-lua lint-sh

lint-lua:
	luacheck *.lua lua/* tests/*

lint-sh:
	shfmt -f . | grep -v jdtls | xargs shellcheck

style: style-lua style-sh

style-lua:
	stylua --config-path .stylua.toml --check .

style-sh:
	shfmt -f . | grep -v jdtls | xargs shfmt -i 2 -ci -bn -l -d

test:
	bash ./utils/ci/run_test.sh "$(TEST)"

.PHONY: install install-neovim-binary uninstall lint style test

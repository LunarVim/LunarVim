
SHELL := /bin/bash

install:
	@echo Starting LunarVim Installer
	bash ./utils/installer/install.sh

uninstall:
	@echo TODO: this is currently not supported 

install-neovim-binary:
	@echo Installing Neovim from github releases
	bash ./utils/installer/install-neovim-from-release

test:
	bash ./utils/bin/test_runner.sh "$(UNIT)"

lint: lint-lua lint-sh

style: style-lua style-sh

lint-lua:
	luacheck *.lua lua/* tests/*
lint-sh:
	shfmt -f . | grep -v jdtls | xargs shellcheck

style-lua:
	stylua --check .
style-sh:
	shfmt -f . | grep -v jdtls | xargs shfmt -i=2 -ci -w

.PHONY: test lint style install install-neovim-binary uninstall

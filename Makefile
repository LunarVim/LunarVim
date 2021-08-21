test:
	nvim --headless -u ./init.lua -c "PlenaryBustedDirectory tests/ { minimal_init = './init.lua' }"
#	nvim --headless -u tests/minimal_init.lua -c "PlenaryBustedDirectory tests/ { minimal_init = './tests/minimal_init.lua' }"

lint: lint-lua lint-sh

lint-lua:
	pre-commit run --all-files luacheck
lint-sh:
	pre-commit run --all-files shellcheck

style: style-lua style-sh

style-lua:
	pre-commit run --all-files stylua
style-sh:
	pre-commit run --all-files shfmt

.PHONY: test lint lint-sh lint-lua style style-lua style-sh

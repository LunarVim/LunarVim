test:
	nvim --headless -u ./init.lua -c "PlenaryBustedDirectory tests/ { minimal_init = './init.lua' }"

test-minimal:
	nvim --headless -u tests/minimal_init.lua -c "PlenaryBustedDirectory tests/ { minimal_init = './tests/minimal_init.lua' }"

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

.PHONY: test test-minimal lint lint-sh lint-lua style style-lua style-sh

#!/usr/bin/env bash
set -e

export LUNARVIM_RUNTIME_DIR="${LUNARVIM_RUNTIME_DIR:-"$HOME/.local/share/lunarvim"}"

export LVIM_TEST_ENV=true

# we should start with an empty configuration
LUNARVIM_CONFIG_DIR="$(mktemp -d)"
LUNARVIM_CACHE_DIR="$(mktemp -d)"

export LUNARVIM_CONFIG_DIR LUNARVIM_CACHE_DIR

echo "cache: $LUNARVIM_CACHE_DIR

config: $LUNARVIM_CONFIG_DIR"

lvim() {
  nvim -u "$LUNARVIM_RUNTIME_DIR/lvim/tests/minimal_init.lua" --cmd "set runtimepath+=$LUNARVIM_RUNTIME_DIR/lvim" "$@"
}

if [ -n "$1" ]; then
  lvim --headless -c "lua require('plenary.busted').run('$1')"
else
  lvim --headless -c "PlenaryBustedDirectory tests/specs { minimal_init = './tests/minimal_init.lua' }"
fi

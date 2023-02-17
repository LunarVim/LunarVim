#!/usr/bin/env bash
set -e

export NVIM_APPNAME="${NVIM_APPNAME:-"lvim"}"

export LUNARVIM_DATA_DIR="${LUNARVIM_DATA_DIR:-"$HOME/.local/share/$NVIM_APPNAME"}"
export LUNARVIM_BASE_DIR="$LUNARVIM_DATA_DIR/core"

export LVIM_TEST_ENV=true

lvim() {
  nvim -u "$LUNARVIM_BASE_DIR/tests/minimal_init.lua" "$@"
}

if [ -n "$1" ]; then
  lvim --headless -c "lua require('plenary.busted').run('$1')"
else
  lvim --headless -c "PlenaryBustedDirectory tests/specs { minimal_init = './tests/minimal_init.lua' }"
fi

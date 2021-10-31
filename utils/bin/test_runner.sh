#!/usr/bin/env bash
set -e

export LUNARVIM_CONFIG_DIR="${LUNARVIM_CONFIG_DIR:-"$HOME/.config/lvim"}"
export LUNARVIM_RUNTIME_DIR="${LUNARVIM_RUNTIME_DIR:-"$HOME/.local/share/lunarvim"}"

export LVIM_TEST_ENV=true

rm -f "$LUNARVIM_CONFIG_DIR/plugin/packer_compiled.lua"

lvim() {
  # TODO: allow running with a minimal_init.lua
  nvim -u "$LUNARVIM_RUNTIME_DIR/lvim/tests/minimal_init.lua" --cmd "set runtimepath+=$LUNARVIM_RUNTIME_DIR/lvim" "$@"
}

if [ -n "$1" ]; then
  lvim --headless -c "lua require('plenary.busted').run('$1')"
else
  lvim --headless -c "PlenaryBustedDirectory tests/ { minimal_init = './tests/minimal_init.lua' }"
fi

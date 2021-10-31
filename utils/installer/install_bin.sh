#!/usr/bin/env bash
set -eo pipefail

declare -r INSTALL_PREFIX="${INSTALL_PREFIX:-"$HOME/.local"}"

declare -r XDG_DATA_HOME="${XDG_DATA_HOME:-"$HOME/.local/share"}"
declare -r XDG_CACHE_HOME="${XDG_CACHE_HOME:-"$HOME/.cache"}"
declare -r XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"$HOME/.config"}"

declare -r LUNARVIM_RUNTIME_DIR="${LUNARVIM_RUNTIME_DIR:-"$XDG_DATA_HOME/lunarvim"}"
declare -r LUNARVIM_CONFIG_DIR="${LUNARVIM_CONFIG_DIR:-"$XDG_CONFIG_HOME/lvim"}"

# TODO: Use a dedicated cache directory #1256
declare -r LUNARVIM_CACHE_DIR="$XDG_CACHE_HOME/nvim"

function setup_shim() {
  if [ ! -d "$INSTALL_PREFIX/bin" ]; then
    mkdir -p "$INSTALL_PREFIX/bin"
  fi
  cat >"$INSTALL_PREFIX/bin/lvim" <<EOF
#!/bin/sh

export LUNARVIM_CONFIG_DIR="\${LUNARVIM_CONFIG_DIR:-$LUNARVIM_CONFIG_DIR}"
export LUNARVIM_RUNTIME_DIR="\${LUNARVIM_RUNTIME_DIR:-$LUNARVIM_RUNTIME_DIR}"
export LUNARVIM_CACHE_DIR="\${LUNARVIM_CACHE_DIR:-$LUNARVIM_CACHE_DIR}"

exec nvim -u "\$LUNARVIM_RUNTIME_DIR/lvim/init.lua" "\$@"
EOF
  chmod +x "$INSTALL_PREFIX/bin/lvim"
}

setup_shim "$@"
echo "You can start LunarVim by running: $INSTALL_PREFIX/bin/lvim"

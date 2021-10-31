#!/usr/bin/env bash

declare -r INSTALL_PREFIX="${INSTALL_PREFIX:-"$HOME/.local"}"
declare -r LUNARVIM_RUNTIME_DIR="yyyy"
declare -r LUNARVIM_CONFIG_DIR="xxxx"


function setup_shim() {
  if [ ! -d "$INSTALL_PREFIX/bin" ]; then
    mkdir -p "$INSTALL_PREFIX/bin"
  fi
  touch "$INSTALL_PREFIX/bin/lvimTest"
  cat >"$INSTALL_PREFIX/bin/lvimTest" <<EOF
#!/bin/sh

export LUNARVIM_CONFIG_DIR="${LUNARVIM_CONFIG_DIR:-/home/dave/.config/lvim}"
export LUNARVIM_RUNTIME_DIR="${LUNARVIM_RUNTIME_DIR:-/home/dave/.local/share/lunarvim}"

exec nvim -u "\$LUNARVIM_CONFIG_DIR/init.lua" "\$@"
EOF
}


setup_shim

#!/usr/bin/env bash
set -eo pipefail

XDG_DATA_HOME="${XDG_DATA_HOME:-"$HOME/.local/share"}"

NVIM_APPNAME="${NVIM_APPNAME:-"lvim"}"
LUNARVIM_DATA_DIR="$XDG_DATA_HOME/$NVIM_APPNAME"
LUNARVIM_BASE_DIR="$LUNARVIM_DATA_DIR/core"

function setup_shim() {
  local src="$LUNARVIM_BASE_DIR/utils/bin/lvim.template"
  local dst="$HOME/.local/bin/$NVIM_APPNAME"

  [ ! -d "$HOME/.local/bin" ] && mkdir -p "$HOME/.local/bin"

  # remove outdated installation so that `cp` doesn't complain
  rm -f "$dst"

  cp "$src" "$dst"

  sed -e s"#NVIM_APPNAME_VAR#${NVIM_APPNAME}#"g \
    -e s"#XDG_DATA_HOME_VAR#${XDG_DATA_HOME}#"g "$src" \
    | tee "$dst" >/dev/null

  chmod u+x "$dst"
}

setup_shim "$@"

echo "You can start LunarVim by running: $HOME/.local/bin/$NVIM_APPNAME"

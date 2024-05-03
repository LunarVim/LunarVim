#!/usr/bin/env bash
set -eo pipefail

ARGS_REMOVE_BACKUPS=0
ARGS_REMOVE_CONFIG=0

declare -r XDG_DATA_HOME="${XDG_DATA_HOME:-"$HOME/.local/share"}"
declare -r XDG_CACHE_HOME="${XDG_CACHE_HOME:-"$HOME/.cache"}"
declare -r XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"$HOME/.config"}"

declare -xr NVIM_APPNAME="${NVIM_APPNAME:-"lvim"}"

declare -xr LUNARVIM_RUNTIME_DIR="${LUNARVIM_RUNTIME_DIR:-"$XDG_DATA_HOME/lunarvim"}"
declare -xr LUNARVIM_CONFIG_DIR="${LUNARVIM_CONFIG_DIR:-"$XDG_CONFIG_HOME/$NVIM_APPNAME"}"
declare -xr LUNARVIM_CACHE_DIR="${LUNARVIM_CACHE_DIR:-"$XDG_CACHE_HOME/$NVIM_APPNAME"}"
declare -xr LUNARVIM_BASE_DIR="${LUNARVIM_BASE_DIR:-"$LUNARVIM_RUNTIME_DIR/$NVIM_APPNAME"}"

declare -a __lvim_dirs=(
  "$LUNARVIM_RUNTIME_DIR"
  "$LUNARVIM_CACHE_DIR"
)

__lvim_config_dir="$LUNARVIM_CONFIG_DIR"

function usage() {
  echo "Usage: uninstall.sh [<options>]"
  echo ""
  echo "Options:"
  echo "    -h, --help                       Print this help message"
  echo "    --remove-config                  Remove user config files as well"
  echo "    --remove-backups                 Remove old backup folders as well"
}

function parse_arguments() {
  while [ "$#" -gt 0 ]; do
    case "$1" in
      --remove-backups)
        ARGS_REMOVE_BACKUPS=1
        ;;
      --remove-config)
        ARGS_REMOVE_CONFIG=1
        ;;
      -h | --help)
        usage
        exit 0
        ;;
    esac
    shift
  done
}

function remove_lvim_dirs() {
  if [ "$ARGS_REMOVE_CONFIG" -eq 1 ]; then
    __lvim_dirs+=("$__lvim_config_dir")
  fi
  for dir in "${__lvim_dirs[@]}"; do
    rm -rf "$dir"
    if [ "$ARGS_REMOVE_BACKUPS" -eq 1 ]; then
      rm -rf "$dir.{bak,old}"
    fi
  done
}

function remove_lvim_bin() {
  lvim_bin="$(command -v "$NVIM_APPNAME" 2>/dev/null)"
  rm -f "$lvim_bin"
}

function remove_desktop_file() {
  OS="$(uname -s)"
  # TODO: Any other OSes that use desktop files?
  ([ "$OS" != "Linux" ] || ! command -v xdg-desktop-menu &>/dev/null) && return
  echo "Removing desktop file..."

  find "$XDG_DATA_HOME/icons/hicolor" -name "lvim.svg" -type f -delete
  xdg-desktop-menu uninstall lvim.desktop
}

function main() {
  parse_arguments "$@"
  echo "Removing LunarVim binary..."
  remove_lvim_bin
  echo "Removing LunarVim directories..."
  remove_lvim_dirs
  remove_desktop_file
  echo "Uninstalled LunarVim!"
}

main "$@"

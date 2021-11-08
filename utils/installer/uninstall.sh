#!/usr/bin/env bash
set -eo pipefail

ARGS_REMOVE_BACKUPS=0

declare -r XDG_DATA_HOME="${XDG_DATA_HOME:-"$HOME/.local/share"}"
declare -r XDG_CACHE_HOME="${XDG_CACHE_HOME:-"$HOME/.cache"}"
declare -r XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"$HOME/.config"}"

declare -r LUNARVIM_RUNTIME_DIR="${LUNARVIM_RUNTIME_DIR:-"$XDG_DATA_HOME/lunarvim"}"
declare -r LUNARVIM_CONFIG_DIR="${LUNARVIM_CONFIG_DIR:-"$XDG_CONFIG_HOME/lvim"}"

# TODO: Use a dedicated cache directory #1256
declare -r LUNARVIM_CACHE_DIR="$XDG_CACHE_HOME/nvim"

LVIM_BIN="$(which lvim 2>/dev/null)"

declare -a __lvim_dirs=(
  "$LUNARVIM_CONFIG_DIR"
  "$LUNARVIM_RUNTIME_DIR"
  "$LUNARVIM_CACHE_DIR"
)

function usage() {
  echo "Usage: uninstall.sh [<options>]"
  echo ""
  echo "Options:"
  echo "    -h, --help                       Print this help message"
  echo "    --remove-backups                 Remove old backup folders as well"
}

function parse_arguments() {
  while [ "$#" -gt 0 ]; do
    case "$1" in
      --remove-backups)
        ARGS_REMOVE_BACKUPS=1
        ;;
      -h | --help)
        usage
        exit 0
        ;;
    esac
    shift
  done
}

function main() {
  parse_arguments "$@"
  for dir in "${__lvim_dirs[@]}"; do
    rm -rf "$dir"
    if [ "$ARGS_REMOVE_BACKUPS" -eq 1 ]; then
      rm -rf "$dir.bak"
    fi
  done
  rm -f "$LVIM_BIN"
}

main "$@"

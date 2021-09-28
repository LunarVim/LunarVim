#!/usr/bin/env bash

LUNARVIM_RUNTIME_DIR="${LUNARVIM_RUNTIME_DIR:-"$HOME/.local/share/lunarvim"}"
LUNARVIM_CONFIG_DIR="${LUNARVIM_CONFIG_DIR:-"$HOME/.config/lvim"}"

function usage() {
  echo "Usage: install.sh [<options>]"
  echo ""
  echo "Options:"
  echo "    -h, --help    print this help message"
  echo "    -q, --quiet   disable all output"
}

function main() {

  parse_arguments "$@"

  msg "Clearing up old startup cache"

  lvim --headless -E -R +LvimCacheReset +q

  msg "Your LunarVim installation is now up to date!"
}

function parse_arguments() {
  while [ "$#" -gt 0 ]; do
    case "$1" in
      -q | --quiet)
        QUIET="y"
        ;;
      -h | --help)
        usage
        exit 0
        ;;
    esac
    shift
  done
}

function msg() {

  if [ -n "$QUIET" ]; then
    return
  fi

  local text="$1"
  local div_width="80"
  printf "%${div_width}s\n" ' ' | tr ' ' -
  printf "%s\n" "$text"
}

function update_lvim() {
  msg "Checking for updates"

  git -C "$LUNARVIM_RUNTIME_DIR/lvim" fetch --quiet

  if ! git -C "$LUNARVIM_RUNTIME_DIR/lvim" diff-index --quiet "@{upstream}" 2>/dev/null; then
    if ! git -C "$LUNARVIM_RUNTIME_DIR/lvim" merge --ff-only --progress 2>/dev/null; then
      msg "Error: unable to guarantee data integrity while updating your branch.\nPlease pull the changes manually instead."
      exit 1
    fi
  fi

}

main "$@"

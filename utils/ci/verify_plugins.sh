#!/usr/bin/env bash
set -e

BASEDIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
BASEDIR="$(dirname -- "$(dirname -- "$BASEDIR")")"

LUNARVIM_BASE_DIR="${LUNARVIM_BASE_DIR:-"$BASEDIR"}"

lvim --headless \
  -c "luafile ${LUNARVIM_BASE_DIR}/utils/ci/verify_plugins.lua"

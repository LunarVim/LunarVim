#!/usr/bin/env bash
set -e

lvim --headless \
  -c "luafile ./utils/ci/verify_plugins.lua"

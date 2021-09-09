#!/usr/bin/env bash
set -e

# TODO: allow running with a minimal_init.lua
if [ -n "$1" ]; then
  nvim --headless -u ./init.lua -c "lua require('plenary.busted').run('$1')"
else
  nvim --headless -u ./init.lua -c "PlenaryBustedDirectory tests/ { minimal_init = './init.lua' }"
fi

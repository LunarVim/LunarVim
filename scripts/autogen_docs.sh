#!/usr/bin/env bash
set -ex

# we should start with an empty configuration
TEST_BASE_DIR="$(mktemp -d)"

export LUNARVIM_CONFIG_DIR="$TEST_BASE_DIR"
export LUNARVIM_CACHE_DIR="$TEST_BASE_DIR"

touch "$LUNARVIM_CONFIG_DIR/config.lua"

lvim --headless \
  +"luafile scripts/autogen_lsp_docs.lua" \
  +"qall"

# lvim --headless \
#   +"luafile scripts/autogen_plugins_docs.lua" \
#   +"qall"

# yarn run prettier -w scripts/core_plugins.*

# mv scripts/core_plugins.md docs/plugins/01-core-plugins-list.md

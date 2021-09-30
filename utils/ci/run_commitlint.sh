#!/usr/bin/env bash
set -eo pipefail

REPO_DIR="$(git rev-parse --show-toplevel)"
HELP_URL="https://github.com/LunarVim/LunarVim/blob/rolling/CONTRIBUTING.md#commit-messages"
CONFIG="$REPO_DIR/.github/workflows/commitlint.config.js"

if ! npx commitlint --edit --verbose --help-url "$HELP_URL" --config "$CONFIG"; then
  exit 1
fi

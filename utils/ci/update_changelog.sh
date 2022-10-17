#!/usr/bin/env bash
set -eo pipefail

BRANCH="$(git rev-parse --abbrev-ref HEAD)"

if [ "$BRANCH" != "master" ]; then
  exit 0
fi

REPO_DIR="$(git rev-parse --show-toplevel)"
LATEST_TAG="$(git describe --tags --abbrev=0)"
CONFIG_FILE="$REPO_DIR/.github/workflows/cliff.toml"
CHANGELOG="$REPO_DIR/CHANGELOG.md"

git -C "$REPO_DIR" cliff "$LATEST_TAG"..HEAD -u -c "$CONFIG_FILE" -p "$CHANGELOG"

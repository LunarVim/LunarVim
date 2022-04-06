#!/usr/bin/env bash
set -e

REPO_DIR=$(git rev-parse --show-toplevel)

export SNAPSHOT_NAME="default.json"
export SNAPSHOT_DIR="${REPO_DIR}/snapshots"

mkdir -p "${SNAPSHOT_DIR}"

export SNAPSHOT_PATH="${REPO_DIR}/snapshots/${SNAPSHOT_NAME}"

time lvim --headless \
  -c "luafile ./utils/ci/generate_new_lockfile.lua"

temp=$(mktemp)

jq --sort-keys . "${SNAPSHOT_PATH}" >"${temp}"
mv "${temp}" "${SNAPSHOT_PATH}"

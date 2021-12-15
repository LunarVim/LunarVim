#!/bin/sh

headless_update() {
  exec nvim --cmd 'lua _G.__lvim_updating=true' -u "$LUNARVIM_RUNTIME_DIR/lvim/init.lua" --noplugin -n -i NONE --headless
}

update_fail() {
  echo "$1"
  echo "Updating failed."
  exit 1
}

update() {
  echo 'Updating LunarVim...'
  old="$(pwd)"
  cd "$LUNARVIM_RUNTIME_DIR/lvim" || update_fail "Unable to find LunarVim installation"
  target_branch="${1:-$(git rev-parse --abbrev-ref HEAD)}"
  if git stash --include-untracked -m "Changes before LunarVim update"; then
    echo "Uncommitted changes saved to stash"
  else
    update_fail "Unable to stash uncommitted changes"
  fi
  git fetch --force --depth=1 origin "$target_branch:$target_branch" || update_fail "Unable to fetch remote branch $target_branch"
  git checkout "$target_branch" || update_fail "Unable to checkout branch $target_branch"
  cd "$old" || update_fail "Unable to change to original directory"
  headless_update

  exit
}

update_core() {
  echo 'Updating core plugins from local...'
  headless_update

  exit
}

help() {
  # See: https://github.com/koalaman/shellcheck/wiki/SC1004#exceptions
  # shellcheck disable=SC1004
  nvim --help | sed 's/nvim/lvim/g;/^Options:/a\
  --update              Update LunarVim to the latest version\
  --update <branch>     Update LunarVim to use the remote <branch>\
  '

  exit
}

for arg; do
  shift
  case $arg in
    --update) update "$@" ;;
    --update-core) update_core "$@" ;;
    -h | --help) help "$@" ;;
    *) set -- "$@" "$arg" ;;
  esac
done

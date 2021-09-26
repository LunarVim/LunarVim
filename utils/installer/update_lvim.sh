#!/usr/bin/env bash

LUNARVIM_RUNTIME_DIR="${LUNARVIM_RUNTIME_DIR:-"$HOME/.local/share/lunarvim"}"
LUNARVIM_CONFIG_DIR="${LUNARVIM_CONFIG_DIR:-"$HOME/.config/lvim"}"

function update_lvim() {
  echo "Checking for updates"
  git -C "$LUNARVIM_RUNTIME_DIR/lvim" fetch --quiet

  if ! git -C "$LUNARVIM_RUNTIME_DIR/lvim" diff --quiet "@{upstream}"; then
    git -C "$LUNARVIM_RUNTIME_DIR/lvim" merge --ff-only --progress ||
      echo "Unable to guarantee data integrity while updating. Please do that manually instead."
  fi

  echo "Clearing up old startup cache"

  bash "$LUNARVIM_RUNTIME_DIR/lvim/utils/installer/install_ft_templates.sh" >/dev/null

  lvim --headless -E -R +LvimCacheReset +q

  printf "\nYour LunarVim installation is now up to date!\n"
}

update_lvim "@"

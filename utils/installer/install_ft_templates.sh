#!/usr/bin/env bash
set -e

declare -x XDG_DATA_HOME="${XDG_DATA_HOME:-"$HOME/.local/share"}"
declare -x XDG_CACHE_HOME="${XDG_CACHE_HOME:-"$HOME/.cache"}"
declare -x XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"$HOME/.config"}"

declare -x LUNARVIM_RUNTIME_DIR="${LUNARVIM_RUNTIME_DIR:-"$XDG_DATA_HOME/lunarvim"}"
declare -x LUNARVIM_CONFIG_DIR="${LUNARVIM_CONFIG_DIR:-"$XDG_CONFIG_HOME/lvim"}"
# TODO: Uxe a dedicated cache directory #1256
declare -x LUNARVIM_CACHE_DIR="$XDG_CACHE_HOME/nvim"
declare -x LUNARVIM_PACK_DIR="$LUNARVIM_RUNTIME_DIR/site/pack"

declare -x LSP_CONFIG_DIR="$LUNARVIM_PACK_DIR/packer/start/nvim-lspconfig"
declare -x LSP_INSTALLER_DIR="$LUNARVIM_PACK_DIR/packer/start/nvim-lsp-installer"

declare -x FT_GEN_DIR="$LUNARVIM_RUNTIME_DIR/site/after/ftplugin"

rm -rf "$FT_GEN_DIR"
mkdir -p "$FT_GEN_DIR"

nvim -u NONE -E -R --headless \
  --cmd "lua vim.opt.rtp:append({ [[$LUNARVIM_RUNTIME_DIR/lvim]], [[$LSP_CONFIG_DIR]], [[$LSP_INSTALLER_DIR]]})" \
  --cmd "lua vim.opt.rtp:remove(vim.fn.stdpath 'config')" \
  +"lua require('utils/templates').generate_templates()" +q

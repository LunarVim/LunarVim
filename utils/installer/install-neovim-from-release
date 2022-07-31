#!/usr/bin/env bash

set -eu pipefall

declare -r LV_INSTALL_PREFIX="${INSTALL_PREFIX:-"$HOME/.local"}"
declare -r RELEASE_VER="${RELEASE_VER:-latest}" # can be set to nightly

declare ARCHIVE_NAME
declare RELEASE_NAME
declare OS

OS="$(uname -s)"

if [ "$OS" == "Linux" ]; then
  ARCHIVE_NAME="nvim-linux64"
  RELEASE_NAME="nvim-linux64"
elif [ "$OS" == "Darwin" ]; then
  ARCHIVE_NAME="nvim-macos"
  # for some reason the archive has a different name
  RELEASE_NAME="nvim-osx64"
else
  echo "$OS platform is not supported currently"
  exit 1
fi

if [[ "${RELEASE_VER}" == "latest" ]]; then
  declare -r RELEASE_URL="https://github.com/neovim/neovim/releases/${RELEASE_VER}/download/${ARCHIVE_NAME}.tar.gz"
else
  declare -r RELEASE_URL="https://github.com/neovim/neovim/releases/download/${RELEASE_VER}/${ARCHIVE_NAME}.tar.gz"
fi
declare -r CHECKSUM_URL="$RELEASE_URL.sha256sum"

DOWNLOAD_DIR="$(mktemp -d)"
readonly DOWNLOAD_DIR

RELEASE_SHA="$(curl -Ls "$CHECKSUM_URL" | awk '{print $1}')"
readonly RELEASE_SHA

function main() {
  if [ ! -d "$LV_INSTALL_PREFIX" ]; then
    mkdir -p "$LV_INSTALL_PREFIX" || __invalid__prefix__handler
  fi
  download_neovim
  verify_neovim
  install_neovim
}

function download_neovim() {
  echo "Downloading Neovim's binary from $RELEASE_VER release.."
  if ! curl --progress-bar --fail -L "$RELEASE_URL" -o "$DOWNLOAD_DIR/$ARCHIVE_NAME.tar.gz"; then
    echo "Download failed.  Check that the release/filename are correct."
    exit 1
  fi
  echo "Download complete!"
}

function verify_neovim() {
  echo "Verifying the installation.."
  DOWNLOADED_SHA="$(openssl dgst -sha256 "$DOWNLOAD_DIR/$ARCHIVE_NAME.tar.gz" | awk '{print $2}')"

  if [ "$RELEASE_SHA" != "$DOWNLOADED_SHA" ]; then
    echo "Error! checksum mismatch."
    echo "Expected: $RELEASE_SHA but got: $DOWNLOADED_SHA"
    exit 1
  fi
  echo "Verification complete!"
}

function install_neovim() {

  echo "Installing Neovim.."
  pushd "$DOWNLOAD_DIR"
  tar -xzf "$DOWNLOAD_DIR/$ARCHIVE_NAME.tar.gz"
  popd
  if [ ! -d "$DOWNLOAD_DIR/$RELEASE_NAME" ]; then
    # fallback to archive name
    RELEASE_NAME="$ARCHIVE_NAME"
  fi
  # https://dev.to/ackshaey/macos-vs-linux-the-cp-command-will-trip-you-up-2p00
  cp -r "$DOWNLOAD_DIR/$RELEASE_NAME/." "$LV_INSTALL_PREFIX"
  echo "Installation complete!"
  echo "Now you can run $LV_INSTALL_PREFIX/bin/nvim"
}

function __invalid__prefix__handler() {
  echo "Error! Invalid value for LV_INSTALL_PREFIX: [$INSTALL_PREFIX]"
  echo "Please verify that the folder exists and re-run the installer!"
  exit 1
}

main "$@"

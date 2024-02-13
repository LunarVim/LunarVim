#!/usr/bin/env bash
set -x
set -e

REPO_DIR=$(readlink -f "$(dirname "$(realpath "$0")")/../../..")
cd "$REPO_DIR"

make configure
mkdir build/bin -p
cd build

rm -rf AppDir
cmake -DCMAKE_INSTALL_PREFIX=/usr -D BUNDLE_PLUGINS=1 "$REPO_DIR"
make install DESTDIR=AppDir

# Only downloads linuxdeploy if the remote file is different from local
if [ -e linuxdeploy-x86_64.AppImage ]; then
  curl -Lo linuxdeploy-x86_64.AppImage \
    -z linuxdeploy-x86_64.AppImage \
    https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage
else
  curl -Lo linuxdeploy-x86_64.AppImage \
    https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage
fi
chmod +x linuxdeploy-x86_64.AppImage

# Appimage set the ARGV0 environment variable. This causes problems in zsh.
# To prevent this, we use wrapper script to unset ARGV0 as AppRun.
# See https://github.com/AppImage/AppImageKit/issues/852
#
cat <<'EOF' >AppDir/AppRun
#!/bin/bash
unset ARGV0
ROOT_DIR="$(dirname "$(readlink -f "${0}")")"
PATH="$ROOT_DIR/usr/bin:$PATH"
exec lvim ${@+"$@"}
EOF
chmod 755 AppDir/AppRun

# bundle NeoVim

if [ -z "$NVIM_VERSION" ]; then
  NVIM_VERSION="stable"
fi
NVIM_LINK="https://github.com/neovim/neovim/releases/download/$NVIM_VERSION/nvim.appimage"

if [ -e nvim.AppImage ]; then
  curl -Lo nvim.AppImage -z nvim.AppImage "$NVIM_LINK"
else
  curl -Lo nvim.AppImage "$NVIM_LINK"
fi
chmod +x nvim.AppImage
./nvim.AppImage --appimage-extract
rm -r squashfs-root/usr/share/metainfo
cp -rn squashfs-root/* AppDir/

# build AppImage

if [ -z "$ARCH" ]; then
  ARCH="$(arch)"
  export ARCH
fi

export OUTPUT=lvim.AppImage
./linuxdeploy-x86_64.AppImage --appdir AppDir -d "$REPO_DIR/utils/desktop/lvim.desktop" -i "$REPO_DIR/utils/desktop/64x64/lvim.svg" --output appimage
mv lvim.AppImage bin/

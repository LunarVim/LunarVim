```
${LVIM_VERSION}
```

## Install

### Windows

#### Zip

1. Download **lvim-win64.zip**
2. Extract the zip.

#### EXE

1. Download **lvim-win64.exe**
2. Run the exe

### macOS

1. Download **lvim-macos.tar.gz**
2. Run `xattr -c ./lvim-macos.tar.gz` (to avoid "unknown developer" warning)
3. Extract: `tar xzvf lvim-macos.tar.gz`
4. Run `./lvim-macos/bin/lvim`

### Linux (x64)

#### Tarball

1. Download **lvim-linux64.tar.gz**
2. Extract: `tar xzvf lvim-linux64.tar.gz`
3. Run `./lvim-linux64/bin/lvim`

#### Debian Package

1. Download **lvim-linux64.deb**
2. Install the package using `sudo apt install ./lvim-linux64.deb`
3. Run `lvim`

#### AppImage

1. Download **lvim.appimage**
2. Run `chmod u+x lvim.appimage && ./lvim.appimage`
   - If your system does not have FUSE you can [extract the appimage](https://github.com/AppImage/AppImageKit/wiki/FUSE#type-2-appimage):
     ```
     ./lvim.AppImage --appimage-extract
     ./squashfs-root/usr/bin/lvim
     ```

## SHA256 Checksums

```
${SHA_LINUX_64_TAR}
${SHA_LINUX_64_DEB}
${SHA_APP_IMAGE}
${SHA_MACOS}
${SHA_WIN_64_ZIP}
${SHA_WIN_64_EXE}
```

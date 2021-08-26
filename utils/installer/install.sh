#!/usr/bin/env bash
set -eo pipefail

#Set branch to master unless specified by the user
declare -r LV_BRANCH="${LV_BRANCH:-rolling}"
declare -r LV_REMOTE="${LV_REMOTE:-lunarvim/lunarvim.git}"
declare -r INSTALL_PREFIX="${INSTALL_PREFIX:-"$HOME/.local"}"

declare -r XDG_DATA_HOME="${XDG_DATA_HOME:-"$HOME/.local/share"}"
declare -r XDG_CACHE_HOME="${XDG_CACHE_HOME:-"$HOME/.cache"}"
declare -r XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"$HOME/.config"}"

# TODO: Use a dedicated cache directory #1256
declare -r NEOVIM_CACHE_DIR="$XDG_CACHE_HOME/nvim"

declare -r LUNARVIM_RUNTIME_DIR="${LUNARVIM_RUNTIME_DIR:-"$XDG_DATA_HOME/lunarvim"}"
declare -r LUNARVIM_CONFIG_DIR="${LUNARVIM_CONFIG_DIR:-"$XDG_CONFIG_HOME/lvim"}"

declare -a __lvim_dirs=(
  "$LUNARVIM_CONFIG_DIR"
  "$LUNARVIM_RUNTIME_DIR"
  "$NEOVIM_CACHE_DIR" # for now this is shared with neovim
)

declare -a __npm_deps=(
  "neovim"
  "tree-sitter-cli"
)

declare -a __pip_deps=(
  "pynvim"
)

function main() {
  cat <<'EOF'

      88\                                                   88\               
      88 |                                                  \__|              
      88 |88\   88\ 888888$\   888888\   888888\ 88\    88\ 88\ 888888\8888\  
      88 |88 |  88 |88  __88\  \____88\ 88  __88\\88\  88  |88 |88  _88  _88\ 
      88 |88 |  88 |88 |  88 | 888888$ |88 |  \__|\88\88  / 88 |88 / 88 / 88 |
      88 |88 |  88 |88 |  88 |88  __88 |88 |       \88$  /  88 |88 | 88 | 88 |
      88 |\888888  |88 |  88 |\888888$ |88 |        \$  /   88 |88 | 88 | 88 |
      \__| \______/ \__|  \__| \_______|\__|         \_/    \__|\__| \__| \__|

EOF

  __add_separator "80"

  echo "Detecting platform for managing any additional neovim dependencies"
  detect_platform

  if [ -n "$GITHUB_ACTIONS" ]; then
    setup_lvim
    exit 0
  fi

  check_system_deps

  __add_separator "80"

  echo "Would you like to check lunarvim's NodeJS dependencies?"
  read -p "[y]es or [n]o (default: no) : " -r answer
  [ "$answer" != "${answer#[Yy]}" ] && install_nodejs_deps

  echo "Would you like to check lunarvim's Python dependencies?"
  read -p "[y]es or [n]o (default: no) : " -r answer
  [ "$answer" != "${answer#[Yy]}" ] && install_python_deps

  echo "Would you like to check lunarvim's Rust dependencies?"
  read -p "[y]es or [n]o (default: no) : " -r answer
  [ "$answer" != "${answer#[Yy]}" ] && install_rust_deps

  __add_separator "80"

  echo "Backing up old LunarVim configuration"
  backup_old_config

  __add_separator "80"

  case "$@" in
    *--overwrite*)
      echo "!!Warning!! -> Removing all lunarvim related config \
        because of the --overwrite flag"
      read -p "Would you like to continue? [y]es or [n]o : " -r answer
      [ "$answer" == "${answer#[Yy]}" ] && exit 1
      for dir in "${__lvim_dirs[@]}"; do
        [ -d "$dir" ] && rm -rf "$dir"
      done
      ;;
  esac

  if [ -e "$LUNARVIM_RUNTIME_DIR/site/pack/packer/start/packer.nvim" ]; then
    echo "Packer already installed"
  else
    install_packer
  fi

  __add_separator "80"

  if [ -e "$LUNARVIM_RUNTIME_DIR/lvim/init.lua" ]; then
    echo "Updating LunarVim"
    update_lvim
  else
    clone_lvim
    setup_lvim
  fi

  __add_separator "80"

}

function detect_platform() {
  OS="$(uname -s)"
  case "$OS" in
    Linux)
      if [ -f "/etc/arch-release" ] || [ -f "/etc/artix-release" ]; then
        RECOMMEND_INSTALL="sudo pacman -S"
      elif [ -f "/etc/fedora-release" ] || [ -f "/etc/redhat-release" ]; then
        RECOMMEND_INSTALL="sudo dnf install -y"
      elif [ -f "/etc/gentoo-release" ]; then
        RECOMMEND_INSTALL="emerge install -y"
      else # assume debian based
        RECOMMEND_INSTALL="sudo apt install -y"
      fi
      ;;
    Darwin)
      RECOMMEND_INSTALL="brew install"
      ;;
    *)
      echo "OS $OS is not currently supported."
      exit 1
      ;;
  esac
}

function print_missing_dep_msg() {
  echo "[ERROR]: Unable to find dependency [$1]"
  echo "Please install it first and re-run the installer. Try: $RECOMMEND_INSTALL $1"
}

function check_dep() {
  if ! command -v "$1" &>/dev/null; then
    print_missing_dep_msg "$1"
    exit 1
  fi
}

function check_system_deps() {
  if ! command -v git &>/dev/null; then
    print_missing_dep_msg "git"
    exit 1
  fi
  if ! command -v nvim &>/dev/null; then
    print_missing_dep_msg "neovim"
    exit 1
  fi
}

function install_nodejs_deps() {
  check_dep "npm"
  echo "Installing node modules with npm.."
  for dep in "${__npm_deps[@]}"; do
    if ! npm ls -g "$dep" &>/dev/null; then
      printf "installing %s .." "$dep"
      npm install -g "$dep"
    fi
  done
  echo "All NodeJS dependencies are succesfully installed"
}

function install_python_deps() {
  echo "Verifying that pip is available.."
  if ! python3 -m ensurepip &>/dev/null; then
    if ! python3 -m pip --version &>/dev/null; then
      print_missing_dep_msg "pip"
      exit 1
    fi
  fi
  echo "Installing with pip.."
  for dep in "${__pip_deps[@]}"; do
    python3 -m pip install --user "$dep"
  done
  echo "All Python dependencies are succesfully installed"
}

function __attempt_to_install_with_cargo() {
  if ! command -v cargo &>/dev/null; then
    echo "Installing missing Rust dependency with cargo"
    cargo install "$1"
  else
    echo "[WARN]: Unable to find fd. Make sure to install it to avoid any problems"
  fi
}

# we try to install the missing one with cargo even though it's unlikely to be found
function install_rust_deps() {
  if ! command -v fd &>/dev/null; then
    __attempt_to_install_with_cargo "fd-find"
  fi
  if ! command -v rg &>/dev/null; then
    __attempt_to_install_with_cargo "ripgrep"
  fi
  echo "All Rust dependencies are succesfully installed"
}

function backup_old_config() {
  for dir in "${__lvim_dirs[@]}"; do
    # we create an empty folder for subsequent commands \
    # that require an existing directory
    mkdir -p "$dir" "$dir.bak"
    if command -v rsync &>/dev/null; then
      rsync --archive -hh --partial --progress \
        --modify-window=1 "$dir"/ "$dir.bak"
    else
      cp -R "$dir/*" "$dir.bak/."
    fi
  done
  echo "Backup operation complete"
}

function install_packer() {
  git clone --progress --depth 1 https://github.com/wbthomason/packer.nvim \
    "$LUNARVIM_RUNTIME_DIR/site/pack/packer/start/packer.nvim"
}

function clone_lvim() {
  echo "Cloning LunarVim configuration"
  if ! git clone --progress --branch "$LV_BRANCH" \
    --depth 1 "https://github.com/${LV_REMOTE}" "$LUNARVIM_RUNTIME_DIR/lvim"; then
    echo "Failed to clone repository. Installation failed."
    exit 1
  fi
}

function setup_shim() {
  if [ ! -d "$INSTALL_PREFIX/bin" ]; then
    mkdir -p "$INSTALL_PREFIX/bin"
  fi
  cat >"$INSTALL_PREFIX/bin/lvim" <<EOF
#!/bin/sh

export LUNARVIM_CONFIG_DIR="\${LUNARVIM_CONFIG_DIR:-$LUNARVIM_CONFIG_DIR}"
export LUNARVIM_RUNTIME_DIR="\${LUNARVIM_RUNTIME_DIR:-$LUNARVIM_RUNTIME_DIR}"

exec nvim -u "\$LUNARVIM_RUNTIME_DIR/lvim/init.lua" "\$@"
EOF
  chmod +x "$INSTALL_PREFIX/bin/lvim"
}

function setup_lvim() {
  echo "Installing LunarVim shim"

  setup_shim

  echo "Preparing Packer setup"

  cp "$LUNARVIM_RUNTIME_DIR/lvim/utils/installer/config.example-no-ts.lua" \
    "$LUNARVIM_CONFIG_DIR/config.lua"

  nvim -u "$LUNARVIM_RUNTIME_DIR/lvim/init.lua" --headless \
    +'autocmd User PackerComplete sleep 100m | qall' \
    +PackerInstall

  nvim -u "$LUNARVIM_RUNTIME_DIR/lvim/init.lua" --headless \
    +'autocmd User PackerComplete sleep 100m | qall' \
    +PackerSync

  echo "Packer setup complete"

  cp "$LUNARVIM_RUNTIME_DIR/lvim/utils/installer/config.example.lua" "$LUNARVIM_CONFIG_DIR/config.lua"

  echo "Thank you for installing LunarVim!!"
  echo "You can start it by running: $INSTALL_PREFIX/bin/lvim"
  echo "Do not forget to use a font with glyphs (icons) support [https://github.com/ryanoasis/nerd-fonts]"
}

function update_lvim() {
  if ! git -C "$LUNARVIM_RUNTIME_DIR/lvim" status -uno &>/dev/null; then
    git -C "$LUNARVIM_RUNTIME_DIR/lvim" pull --ff-only --progress ||
      echo "Unable to guarantee data integrity while updating. Please do that manually instead." && exit 1
  fi
  echo "Your LunarVim installation is now up to date!"
}

function __add_separator() {
  local DIV_WIDTH="$1"
  printf "%${DIV_WIDTH}s\n" ' ' | tr ' ' -
}

main "$@"

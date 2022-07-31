#!/usr/bin/env bash
set -eo pipefail

#Set branch to master unless specified by the user
declare LV_BRANCH="${LV_BRANCH:-"master"}"
declare -r LV_REMOTE="${LV_REMOTE:-lunarvim/lunarvim.git}"
declare -r INSTALL_PREFIX="${INSTALL_PREFIX:-"$HOME/.local"}"

declare -r XDG_DATA_HOME="${XDG_DATA_HOME:-"$HOME/.local/share"}"
declare -r XDG_CACHE_HOME="${XDG_CACHE_HOME:-"$HOME/.cache"}"
declare -r XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"$HOME/.config"}"

declare -r LUNARVIM_RUNTIME_DIR="${LUNARVIM_RUNTIME_DIR:-"$XDG_DATA_HOME/lunarvim"}"
declare -r LUNARVIM_CONFIG_DIR="${LUNARVIM_CONFIG_DIR:-"$XDG_CONFIG_HOME/lvim"}"
declare -r LUNARVIM_CACHE_DIR="${LUNARVIM_CACHE_DIR:-"$XDG_CACHE_HOME/lvim"}"
declare -r LUNARVIM_BASE_DIR="${LUNARVIM_BASE_DIR:-"$LUNARVIM_RUNTIME_DIR/lvim"}"

declare -r LUNARVIM_LOG_LEVEL="${LUNARVIM_LOG_LEVEL:-warn}"

declare BASEDIR
BASEDIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
BASEDIR="$(dirname -- "$(dirname -- "$BASEDIR")")"
readonly BASEDIR

declare ARGS_LOCAL=0
declare ARGS_OVERWRITE=0
declare ARGS_INSTALL_DEPENDENCIES=1
declare INTERACTIVE_MODE=1

declare -a __lvim_dirs=(
  "$LUNARVIM_CONFIG_DIR"
  "$LUNARVIM_RUNTIME_DIR"
  "$LUNARVIM_CACHE_DIR"
)

declare -a __npm_deps=(
  "neovim"
  "tree-sitter-cli"
)

declare -a __pip_deps=(
  "pynvim"
)

function usage() {
  echo "Usage: install.sh [<options>]"
  echo ""
  echo "Options:"
  echo "    -h, --help                               Print this help message"
  echo "    -l, --local                              Install local copy of LunarVim"
  echo "    -y, --yes                                Disable confirmation prompts (answer yes to all questions)"
  echo "    --overwrite                              Overwrite previous LunarVim configuration (a backup is always performed first)"
  echo "    --[no]-install-dependencies              Whether to automatically install external dependencies (will prompt by default)"
}

function parse_arguments() {
  while [ "$#" -gt 0 ]; do
    case "$1" in
      -l | --local)
        ARGS_LOCAL=1
        ;;
      --overwrite)
        ARGS_OVERWRITE=1
        ;;
      -y | --yes)
        INTERACTIVE_MODE=0
        ;;
      --install-dependencies)
        ARGS_INSTALL_DEPENDENCIES=1
        ;;
      --no-install-dependencies)
        ARGS_INSTALL_DEPENDENCIES=0
        ;;
      -h | --help)
        usage
        exit 0
        ;;
    esac
    shift
  done
}

function msg() {
  local text="$1"
  local div_width="80"
  printf "%${div_width}s\n" ' ' | tr ' ' -
  printf "%s\n" "$text"
}

function confirm() {
  local question="$1"
  while true; do
    msg "$question"
    read -p "[y]es or [n]o (default: no) : " -r answer
    case "$answer" in
      y | Y | yes | YES | Yes)
        return 0
        ;;
      n | N | no | NO | No | *[[:blank:]]* | "")
        return 1
        ;;
      *)
        msg "Please answer [y]es or [n]o."
        ;;
    esac
  done
}

function main() {
  parse_arguments "$@"

  print_logo

  msg "Detecting platform for managing any additional neovim dependencies"
  detect_platform

  check_system_deps

  if [ "$ARGS_INSTALL_DEPENDENCIES" -eq 1 ]; then
    if [ "$INTERACTIVE_MODE" -eq 1 ]; then
      if confirm "Would you like to install LunarVim's NodeJS dependencies?"; then
        install_nodejs_deps
      fi
      if confirm "Would you like to install LunarVim's Python dependencies?"; then
        install_python_deps
      fi
      if confirm "Would you like to install LunarVim's Rust dependencies?"; then
        install_rust_deps
      fi
    else
      install_nodejs_deps
      install_python_deps
      install_rust_deps
    fi
  fi

  backup_old_config

  verify_lvim_dirs

  if [ "$ARGS_LOCAL" -eq 1 ]; then
    link_local_lvim
  elif [ -d "$LUNARVIM_BASE_DIR" ]; then
    validate_lunarvim_files
  else
    clone_lvim
  fi

  setup_lvim

  msg "Thank you for installing LunarVim!!"
  echo "You can start it by running: $INSTALL_PREFIX/bin/lvim"
  echo "Do not forget to use a font with glyphs (icons) support [https://github.com/ryanoasis/nerd-fonts]"
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
        RECOMMEND_INSTALL="emerge -tv"
      else # assume debian based
        RECOMMEND_INSTALL="sudo apt install -y"
      fi
      ;;
    FreeBSD)
      RECOMMEND_INSTALL="sudo pkg install -y"
      ;;
    NetBSD)
      RECOMMEND_INSTALL="sudo pkgin install"
      ;;
    OpenBSD)
      RECOMMEND_INSTALL="doas pkg_add"
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
  if [ "$#" -eq 1 ]; then
    echo "[ERROR]: Unable to find dependency [$1]"
    echo "Please install it first and re-run the installer. Try: $RECOMMEND_INSTALL $1"
  else
    local cmds
    cmds=$(for i in "$@"; do echo "$RECOMMEND_INSTALL $i"; done)
    printf "[ERROR]: Unable to find dependencies [%s]" "$@"
    printf "Please install any one of the dependencies and re-run the installer. Try: \n%s\n" "$cmds"
  fi
}

function check_neovim_min_version() {
  local verify_version_cmd='if !has("nvim-0.7") | cquit | else | quit | endif'

  # exit with an error if min_version not found
  if ! nvim --headless -u NONE -c "$verify_version_cmd"; then
    echo "[ERROR]: LunarVim requires at least Neovim v0.7 or higher"
    exit 1
  fi
}

function verify_core_plugins() {
  msg "Verifying core plugins"
  if ! bash "$LUNARVIM_BASE_DIR/utils/ci/verify_plugins.sh"; then
    echo "[ERROR]: Unable to verify plugins, make sure to manually run ':PackerSync' when starting lvim for the first time."
    exit 1
  fi
  echo "Verification complete!"
}

function validate_lunarvim_files() {
  local verify_version_cmd='if v:errmsg != "" | cquit | else | quit | endif'
  if ! "$INSTALL_PREFIX/bin/lvim" --headless -c 'LvimUpdate' -c "$verify_version_cmd" &>/dev/null; then
    msg "Removing old installation files"
    rm -rf "$LUNARVIM_BASE_DIR"
    clone_lvim
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
  check_neovim_min_version
}

function __install_nodejs_deps_pnpm() {
  echo "Installing node modules with pnpm.."
  pnpm install -g "${__npm_deps[@]}"
  echo "All NodeJS dependencies are successfully installed"
}

function __install_nodejs_deps_npm() {
  echo "Installing node modules with npm.."
  for dep in "${__npm_deps[@]}"; do
    if ! npm ls -g "$dep" &>/dev/null; then
      printf "installing %s .." "$dep"
      npm install -g "$dep"
    fi
  done

  echo "All NodeJS dependencies are successfully installed"
}

function __install_nodejs_deps_yarn() {
  echo "Installing node modules with yarn.."
  yarn global add "${__npm_deps[@]}"
  echo "All NodeJS dependencies are successfully installed"
}

function __validate_node_installation() {
  local pkg_manager="$1"
  local manager_home

  if ! command -v "$pkg_manager" &>/dev/null; then
    return 1
  fi

  if [ "$pkg_manager" == "npm" ]; then
    manager_home="$(npm config get prefix 2>/dev/null)"
  elif [ "$pkg_manager" == "pnpm" ]; then
    manager_home="$(pnpm config get prefix 2>/dev/null)"
  else
    manager_home="$(yarn global bin 2>/dev/null)"
  fi

  if [ ! -d "$manager_home" ] || [ ! -w "$manager_home" ]; then
    echo "[ERROR] Unable to install using [$pkg_manager] without administrative privileges."
    return 1
  fi

  return 0
}

function install_nodejs_deps() {
  local -a pkg_managers=("pnpm" "yarn" "npm")
  for pkg_manager in "${pkg_managers[@]}"; do
    if __validate_node_installation "$pkg_manager"; then
      eval "__install_nodejs_deps_$pkg_manager"
      return
    fi
  done
  print_missing_dep_msg "${pkg_managers[@]}"
  exit 1
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
  echo "All Python dependencies are successfully installed"
}

function __attempt_to_install_with_cargo() {
  if command -v cargo &>/dev/null; then
    echo "Installing missing Rust dependency with cargo"
    cargo install "$1"
  else
    echo "[WARN]: Unable to find cargo. Make sure to install it to avoid any problems"
    exit 1
  fi
}

# we try to install the missing one with cargo even though it's unlikely to be found
function install_rust_deps() {
  local -a deps=("fd::fd-find" "rg::ripgrep")
  for dep in "${deps[@]}"; do
    if ! command -v "${dep%%::*}" &>/dev/null; then
      __attempt_to_install_with_cargo "${dep##*::}"
    fi
  done
  echo "All Rust dependencies are successfully installed"
}

function verify_lvim_dirs() {
  if [ "$ARGS_OVERWRITE" -eq 1 ]; then
    for dir in "${__lvim_dirs[@]}"; do
      [ -d "$dir" ] && rm -rf "$dir"
    done
  fi

  for dir in "${__lvim_dirs[@]}"; do
    mkdir -p "$dir"
  done
}

function backup_old_config() {
  local src="$LUNARVIM_CONFIG_DIR"
  if [ ! -d "$src" ]; then
    return
  fi
  mkdir -p "$src.old"
  touch "$src/ignore"
  msg "Backing up old $src to $src.old"
  if command -v rsync &>/dev/null; then
    rsync --archive -hh --stats --partial --copy-links --cvs-exclude "$src"/ "$src.old"
  else
    OS="$(uname -s)"
    case "$OS" in
      Linux | *BSD)
        cp -r "$src/"* "$src.old/."
        ;;
      Darwin)
        cp -R "$src/"* "$src.old/."
        ;;
      *)
        echo "OS $OS is not currently supported."
        ;;
    esac
  fi
  msg "Backup operation complete"
}

function clone_lvim() {
  msg "Cloning LunarVim configuration"
  if ! git clone --branch "$LV_BRANCH" \
    --depth 1 "https://github.com/${LV_REMOTE}" "$LUNARVIM_BASE_DIR"; then
    echo "Failed to clone repository. Installation failed."
    exit 1
  fi
}

function link_local_lvim() {
  echo "Linking local LunarVim repo"

  # Detect whether it's a symlink or a folder
  if [ -d "$LUNARVIM_BASE_DIR" ]; then
    echo "Removing old installation files"
    rm -rf "$LUNARVIM_BASE_DIR"
  fi

  echo "   - $BASEDIR -> $LUNARVIM_BASE_DIR"
  ln -s -f "$BASEDIR" "$LUNARVIM_BASE_DIR"
}

function setup_shim() {
  make -C "$LUNARVIM_BASE_DIR" install-bin
}

function remove_old_cache_files() {
  local packer_cache="$LUNARVIM_CONFIG_DIR/plugin/packer_compiled.lua"
  if [ -e "$packer_cache" ]; then
    msg "Removing old packer cache file"
    rm -f "$packer_cache"
  fi

  if [ -e "$LUNARVIM_CACHE_DIR/luacache" ] || [ -e "$LUNARVIM_CACHE_DIR/lvim_cache" ]; then
    msg "Removing old startup cache file"
    rm -f "$LUNARVIM_CACHE_DIR/{luacache,lvim_cache}"
  fi
}

function setup_lvim() {

  remove_old_cache_files

  msg "Installing LunarVim shim"

  setup_shim

  cp "$LUNARVIM_BASE_DIR/utils/installer/config.example.lua" "$LUNARVIM_CONFIG_DIR/config.lua"

  echo "Preparing Packer setup"

  "$INSTALL_PREFIX/bin/lvim" --headless \
    -c "lua require('lvim.core.log'):set_level([[$LUNARVIM_LOG_LEVEL]])" \
    -c 'autocmd User PackerComplete quitall' \
    -c 'PackerSync'

  echo "Packer setup complete"

  verify_core_plugins
}

function print_logo() {
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
}

main "$@"

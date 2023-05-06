#!/usr/bin/env bash
set -eo pipefail

OS="$(uname -s)"

#Set branch to master unless specified by the user
declare -x LV_BRANCH="${LV_BRANCH:-"master"}"
declare -xr LV_REMOTE="${LV_REMOTE:-lunarvim/lunarvim.git}"
declare -xr INSTALL_PREFIX="${INSTALL_PREFIX:-"$HOME/.local"}"

declare -xr XDG_DATA_HOME="${XDG_DATA_HOME:-"$HOME/.local/share"}"
declare -xr XDG_CACHE_HOME="${XDG_CACHE_HOME:-"$HOME/.cache"}"
declare -xr XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"$HOME/.config"}"

declare -xr NVIM_APPNAME="${NVIM_APPNAME:-"lvim"}"

declare -xr LUNARVIM_RUNTIME_DIR="${LUNARVIM_RUNTIME_DIR:-"$XDG_DATA_HOME/lunarvim"}"
declare -xr LUNARVIM_CONFIG_DIR="${LUNARVIM_CONFIG_DIR:-"$XDG_CONFIG_HOME/$NVIM_APPNAME"}"
declare -xr LUNARVIM_CACHE_DIR="${LUNARVIM_CACHE_DIR:-"$XDG_CACHE_HOME/$NVIM_APPNAME"}"
declare -xr LUNARVIM_BASE_DIR="${LUNARVIM_BASE_DIR:-"$LUNARVIM_RUNTIME_DIR/$NVIM_APPNAME"}"

declare -xr LUNARVIM_LOG_LEVEL="${LUNARVIM_LOG_LEVEL:-warn}"

declare BASEDIR
BASEDIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
BASEDIR="$(dirname -- "$(dirname -- "$BASEDIR")")"
readonly BASEDIR

declare ARGS_LOCAL=0
declare ARGS_OVERWRITE=0
declare ARGS_INSTALL_DEPENDENCIES=1
declare INTERACTIVE_MODE=1
declare ADDITIONAL_WARNINGS=""

declare -a __lvim_dirs=(
  "$LUNARVIM_RUNTIME_DIR"
  "$LUNARVIM_CACHE_DIR"
  "$LUNARVIM_BASE_DIR"
)

declare -a __npm_deps=(
  "neovim"
)
# treesitter installed with brew causes conflicts #3738
if ! command -v tree-sitter &>/dev/null; then
  __npm_deps+=("tree-sitter-cli")
fi

declare -a __pip_deps=(
  "pynvim"
)

declare -a __rust_deps=(
  "fd::fd-find"
  "rg::ripgrep"
)

function usage() {
  echo "Usage: install.sh [<options>]"
  echo ""
  echo "Options:"
  echo "    -h, --help                               Print this help message"
  echo "    -l, --local                              Install local copy of LunarVim"
  echo "    -y, --yes                                Disable confirmation prompts (answer yes to all questions)"
  echo "    --overwrite                              Overwrite previous LunarVim configuration (a backup is always performed first)"
  echo "    --[no-]install-dependencies              Whether to automatically install external dependencies (will prompt by default)"
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

function stringify_array() {
  echo -n "${@}" | sed 's/ /, /'
}

function main() {
  parse_arguments "$@"

  print_logo

  msg "Detecting platform for managing any additional neovim dependencies"
  detect_platform

  check_system_deps

  if [ "$ARGS_INSTALL_DEPENDENCIES" -eq 1 ]; then
    if [ "$INTERACTIVE_MODE" -eq 1 ]; then
      if confirm "Would you like to install LunarVim's NodeJS dependencies: $(stringify_array "${__npm_deps[@]}")?"; then
        install_nodejs_deps
      fi
      if confirm "Would you like to install LunarVim's Python dependencies: $(stringify_array "${__pip_deps[@]}")?"; then
        install_python_deps
      fi
      if confirm "Would you like to install LunarVim's Rust dependencies: $(stringify_array "${__rust_deps[@]}")?"; then
        install_rust_deps
      fi
    else
      install_nodejs_deps
      install_python_deps
      install_rust_deps
    fi
  fi

  remove_old_cache_files

  verify_lvim_dirs

  if [ "$ARGS_LOCAL" -eq 1 ]; then
    link_local_lvim
  else
    clone_lvim
  fi

  setup_lvim

  msg "$ADDITIONAL_WARNINGS"
  msg "Thank you for installing LunarVim!!"
  echo "You can start it by running: $INSTALL_PREFIX/bin/$NVIM_APPNAME"
  echo "Do not forget to use a font with glyphs (icons) support [https://github.com/ryanoasis/nerd-fonts]"
}

function detect_platform() {
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
  local verify_version_cmd='if !has("nvim-0.8") | cquit | else | quit | endif'

  # exit with an error if min_version not found
  if ! nvim --headless -u NONE -c "$verify_version_cmd"; then
    echo "[ERROR]: LunarVim requires at least Neovim v0.8 or higher"
    exit 1
  fi
}

function verify_core_plugins() {
  msg "Verifying core plugins"
  if ! bash "$LUNARVIM_BASE_DIR/utils/ci/verify_plugins.sh"; then
    echo "[ERROR]: Unable to verify plugins, make sure to manually run ':Lazy sync' when starting lvim for the first time."
    exit 1
  fi
  echo "Verification complete!"
}

function validate_install_prefix() {
  local prefix="$1"
  case $PATH in
    *"$prefix/bin"*)
      return
      ;;
  esac
  local profile="$HOME/.profile"
  test -z "$ZSH_VERSION" && profile="$HOME/.zshenv"
  ADDITIONAL_WARNINGS="[WARN] the folder $prefix/bin is not on PATH, consider adding 'export PATH=$prefix/bin:\$PATH' to your $profile"

  # avoid problems when calling any verify_* function
  export PATH="$prefix/bin:$PATH"
}

function check_system_deps() {

  validate_install_prefix "$INSTALL_PREFIX"

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
  echo "[WARN]: skipping installing optional nodejs dependencies due to insufficient permissions."
  echo "check how to solve it: https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally"
}

function install_python_deps() {
  echo "Verifying that pip is available.."
  if ! python3 -m ensurepip >/dev/null; then
    if ! python3 -m pip --version &>/dev/null; then
      echo "[WARN]: skipping installing optional python dependencies"
      return 1
    fi
  fi
  echo "Installing with pip.."
  for dep in "${__pip_deps[@]}"; do
    python3 -m pip install --user "$dep" || return 1
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
  for dep in "${__rust_deps[@]}"; do
    if ! command -v "${dep%%::*}" &>/dev/null; then
      __attempt_to_install_with_cargo "${dep##*::}"
    fi
  done
  echo "All Rust dependencies are successfully installed"
}

function __backup_dir() {
  local src="$1"
  if [ ! -d "$src" ]; then
    return
  fi
  mkdir -p "$src.old"
  msg "Backing up old $src to $src.old"
  if command -v rsync &>/dev/null; then
    rsync --archive --quiet --backup --partial --copy-links --cvs-exclude "$src"/ "$src.old"
  else
    case "$OS" in
      Darwin)
        cp -R "$src/." "$src.old/."
        ;;
      *)
        cp -r "$src/." "$src.old/."
        ;;
    esac
  fi
}

function verify_lvim_dirs() {
  for dir in "${__lvim_dirs[@]}"; do
    if [ -d "$dir" ]; then
      if [ "$ARGS_OVERWRITE" -eq 0 ]; then
        __backup_dir "$dir"
      fi
      rm -rf "$dir"
    fi
    mkdir -p "$dir"
  done
  mkdir -p "$LUNARVIM_CONFIG_DIR"
}

function clone_lvim() {
  msg "Cloning LunarVim configuration"
  if ! git clone --branch "$LV_BRANCH" \
    "https://github.com/${LV_REMOTE}" "$LUNARVIM_BASE_DIR"; then
    echo "Failed to clone repository. Installation failed."
    exit 1
  fi
}

function link_local_lvim() {
  echo "Linking local LunarVim repo"

  # Detect whether it's a symlink or a folder
  if [ -d "$LUNARVIM_BASE_DIR" ]; then
    msg "Moving old files to ${LUNARVIM_BASE_DIR}.old"
    mv "$LUNARVIM_BASE_DIR" "${LUNARVIM_BASE_DIR}".old
  fi

  echo "   - $BASEDIR -> $LUNARVIM_BASE_DIR"
  ln -s -f "$BASEDIR" "$LUNARVIM_BASE_DIR"
}

function setup_shim() {
  make -C "$LUNARVIM_BASE_DIR" install-bin
}

function remove_old_cache_files() {
  local lazy_cache="$LUNARVIM_CACHE_DIR/lazy/cache"
  if [ -e "$lazy_cache" ]; then
    msg "Removing old lazy cache file"
    rm -f "$lazy_cache"
  fi
}

function setup_lvim() {

  msg "Installing LunarVim shim"

  setup_shim

  create_desktop_file

  [ ! -f "$LUNARVIM_CONFIG_DIR/config.lua" ] \
    && cp "$LUNARVIM_BASE_DIR/utils/installer/config.example.lua" "$LUNARVIM_CONFIG_DIR/config.lua"

  echo "Preparing Lazy setup"

  "$INSTALL_PREFIX/bin/$NVIM_APPNAME" --headless -c 'quitall'

  printf "\nLazy setup complete"

  verify_core_plugins
}

function create_desktop_file() {
  # TODO: Any other OSes that use desktop files?
  ([ "$OS" != "Linux" ] || ! command -v xdg-desktop-menu &>/dev/null) && return
  echo "Creating desktop file"

  for d in "$LUNARVIM_BASE_DIR"/utils/desktop/*/; do
    size_folder=$(basename "$d")
    mkdir -p "$XDG_DATA_HOME/icons/hicolor/$size_folder/apps/"
    cp "$LUNARVIM_BASE_DIR/utils/desktop/$size_folder/lvim.svg" "$XDG_DATA_HOME/icons/hicolor/$size_folder/apps"
  done

  xdg-desktop-menu install --novendor "$LUNARVIM_BASE_DIR/utils/desktop/lvim.desktop" || true
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

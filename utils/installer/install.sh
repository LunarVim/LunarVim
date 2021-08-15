#!/usr/bin/env bash
set -euo pipefail

#Set branch to master unless specified by the user
declare -r LVBRANCH="${LVBRANCH:-master}"
declare -r LV_REMOTE="${LV_REMOTE:-\"ChristianChiarulli/lunarvim.git\"}"
declare -r INSTALL_PREFIX="${INSTALL_PREFIX:-"$HOME/.local"}"

declare -r XDG_DATA_HOME=${XDG_DATA_HOME:-"$HOME/.local/share"}
declare -r XDG_CACHE_HOME=${XDG_CACHE_HOME:-"$HOME/.cache"}
declare -r XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-"$HOME/.config"}

# declare -r NEOVIM_RUNTIME_DIR="$XDG_DATA_HOME/nvim"
# declare -r NEOVIM_CONFIG_DIR="$XDG_CONFIG_HOME/nvim"
declare -r NEOVIM_CACHE_DIR="$XDG_CACHE_HOME/nvim"

declare -r LUNARVIM_RUNTIME_DIR="${LUNARVIM_RUNTIME_DIR:-$XDG_DATA_HOME/lunarvim}"
declare -r LUNARVIM_CONFIG_DIR="${LUNARVIM_CONFIG_DIR:-$XDG_CONFIG_HOME/lvim}"

# declare -a __nvim_dirs=(
#   "$NEOVIM_CACHE_DIR"
#   "$NEOVIM_CONFIG_DIR"
#   "$NEOVIM_RUNTIME_DIR"
# )

declare -a __lvim_dirs=(
  "$LUNARVIM_CONFIG_DIR"
  "$LUNARVIM_RUNTIME_DIR"
  "$NEOVIM_CACHE_DIR" # for now this is shared with neovim
)

declare -A __system_deps=(
  ["git"]="git"
  ["neovim"]="nvim"
  ["ripgrep"]="rg"
  ["fd-find"]="fd"
)

declare -a __npm_deps=(
  "neovim"
  "tree-sitter-cli"
)

declare -a __pip_deps=(
  "pynvim"
)

function main() {
  # Welcome
  __add_separator "80"

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

  # skip this in a Github workflow
  if [ -z "$GITHUB_ACTIONS" ]; then
    check_system_deps

    __add_separator "80"

    echo "Would you like to check noevim's nodejs dependencies?"
    read -p "[y]es or [n]o (default: no) : " -r answer
    [ "$answer" != "${answer#[Yy]}" ] && install_npm_deps

    echo "Would you like to check noevim's python dependencies?"
    read -p "[y]es or [n]o (default: no) : " -r answer
    [ "$answer" != "${answer#[Yy]}" ] && install_pip_deps

  fi

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

  echo "Thank you for installing LunarVim!!"
  echo "I recommend you also install and activate a font \
 from here: https://github.com/ryanoasis/nerd-fonts"
}

function detect_platform() {
  OS="$(uname -s)"
  if [ "$OS" == "Linux" ]; then
    grep -q Ubuntu /etc/os-release && RECOMMEND_INSTALL="sudo apt install -y" && return
    [ -f "/etc/arch-release" ] && RECOMMEND_INSTALL="sudo pacman -S" && return
    [ -f "/etc/artix-release" ] && RECOMMEND_INSTALL="sudo dnf install -y" && return
    [ -f "/etc/fedora-release" ] && RECOMMEND_INSTALL="sudo dnf install -y" && return
    [ -f "/etc/gentoo-release" ] && RECOMMEND_INSTALL="emerge install -y" && return
  elif [ "$OS" == "Darwin" ]; then
    RECOMMEND_INSTALL="brew install"
  else
    echo "OS $OS is not currently supported."
    exit 1
  fi
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
  for dep in "${!__system_deps[@]}"; do
    if ! command -v "${__system_deps[$dep]}" &>/dev/null; then
      print_missing_dep_msg "$dep"
      exit 1
    fi
  done
}

function install_npm_deps() {
  check_dep "npm"
  check_dep "yarn"
  echo "Installing with npm.."
  for dep in "${__npm_deps[@]}"; do
    if ! npm ls -g "$dep" &>/dev/null; then
      printf "installing %s .." "$dep"
      npm install -g "$dep"
    fi
  done
  echo "all nodejs dependencies are succesfully installed"
}

function install_pip_deps() {
  echo "Verifying that pip is available.."
  if ! python3 -m ensurepip &>/dev/null; then
    print_missing_dep_msg "pip"
    exit 1
  fi
  echo "Installing with pip.."
  for dep in "${__pip_deps[@]}"; do
    pip3 install --user "$dep"
  done
  echo "all python dependencies are succesfully installed"
}

function backup_old_config() {
  for dir in "${__lvim_dirs[@]}"; do
    # we create an empty folder for subsequent commands \
    # that require an existing directory
    mkdir -p "$dir" "$dir.bak"
    if command -v rsync &>/dev/null; then
      rsync --archive -hh --partial --info=stats1 --info=progress2 \
        --modify-window=1 "$dir" "$dir.bak"
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
  local CLONE_CMD="git clone --progress --branch $LVBRANCH \
    --depth 1 https://github.com/$LV_REMOTE $LUNARVIM_RUNTIME_DIR/lvim"
  printf "Running: %s" "$CLONE_CMD"
  eval "$CLONE_CMD"
}

function lvim() {
  if command -v lvim &>/dev/null; then
    eval lvim "$@"
  else
    eval nvim -u "$LUNARVIM_RUNTIME_DIR/lvim/init.lua" --cmd "set runtimepath+=$LUNARVIM_RUNTIME_DIR/lvim" "$@"
  fi
}

function setup_shim() {
  if [ ! -d "$INSTALL_PREFIX/bin" ]; then
    mkdir -p "$INSTALL_PREFIX/bin"
  fi
  cat >"$INSTALL_PREFIX/bin/lvim" <<EOF
#!/usr/bin/env bash

declare -r LUNARVIM_RUNTIME_DIR="$LUNARVIM_RUNTIME_DIR"
declare -r LUNARVIM_CONFIG_DIR="$LUNARVIM_CONFIG_DIR"

exec nvim -u "$LUNARVIM_RUNTIME_DIR/lvim/init.lua" --cmd "set runtimepath+=$LUNARVIM_RUNTIME_DIR/lvim" "\$@"
EOF
}

function setup_lvim() {

  echo "Installing LunarVim shim"

  setup_shim
  chmod u+x "$INSTALL_PREFIX/bin/lvim"

  echo "Preparing Packer setup"

  cp "$LUNARVIM_RUNTIME_DIR/lvim/utils/installer/config.example-no-ts.lua" \
    "$HOME/.config/lvim/config.lua"

  lvim --headless \
    +'autocmd User PackerComplete sleep 100m | qall' \
    +PackerInstall

  lvim --headless \
    +'autocmd User PackerComplete sleep 100m | qall' \
    +PackerSync

  echo "Packer setup complete"

  if [ ! -e "$HOME/.local/share/lunarvim/lvim/init.lua" ]; then
    cp "$LUNARVIM_RUNTIME_DIR/lvim/utils/installer/config.example.lua" "$HOME/.config/lvim/config.lua"
  fi
}

function update_lvim() {
  if ! git -C "$LUNARVIM_RUNTIME_DIR/lvim" status -uno &>/dev/null; then
    git -C "$LUNARVIM_RUNTIME_DIR/lvim" pull --ff-only --progress ||
      echo "Unable to guarantee data integrity while updating. Please do that manually instead." && exit 1
  fi
  echo "Your LunarVim installation is up to date!"
}

function __add_separator() {
  local DIV_WIDTH="$1"
  printf "%${DIV_WIDTH}s\n" ' ' | tr ' ' -
}

main "$@"

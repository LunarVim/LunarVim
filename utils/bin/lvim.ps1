$env:HOME = "$HOME"
$env:USER = "$HOME"
$env:SHELL = "cmd"
$env:TERMINAL = "$env:SHELL"
$env:VIMRUNTIME = "$(scoop prefix neovim-nightly)/share/nvim/runtime";
$env:LUNARVIM_RUNTIME_DIR = "$HOME/.local/share/lunarvim"
$env:LUNARVIM_CONFIG_DIR = "$HOME/.config/lvim"
nvim -u "$LUNARVIM_RUNTIME_DIR/lvim/init.lua" $args
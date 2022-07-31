#Requires -Version 7.1
$ErrorActionPreference = "Stop" # exit when command fails

# set script variables
$LV_BRANCH = $LV_BRANCH ?? "rolling"
$LV_REMOTE = $LV_REMOTE ??  "lunarvim/lunarvim.git"
$INSTALL_PREFIX = $INSTALL_PREFIX ?? "$HOME\.local"

$env:XDG_DATA_HOME = $env:XDG_DATA_HOME ?? $env:APPDATA
$env:XDG_CONFIG_HOME = $env:XDG_CONFIG_HOME ?? $env:LOCALAPPDATA
$env:XDG_CACHE_HOME = $env:XDG_CACHE_HOME ?? $env:TEMP

$env:LUNARVIM_RUNTIME_DIR = $env:LUNARVIM_RUNTIME_DIR ?? "$env:XDG_DATA_HOME\lunarvim"
$env:LUNARVIM_CONFIG_DIR = $env:LUNARVIM_CONFIG_DIR ?? "$env:XDG_CONFIG_HOME\lvim"
$env:LUNARVIM_CACHE_DIR = $env:LUNARVIM_CACHE_DIR ?? "$env:XDG_CACHE_HOME\lvim"
$env:LUNARVIM_BASE_DIR = $env:LUNARVIM_BASE_DIR ?? "$env:LUNARVIM_RUNTIME_DIR\lvim"

$__lvim_dirs = (
    $env:LUNARVIM_BASE_DIR,
    $env:LUNARVIM_RUNTIME_DIR,
    $env:LUNARVIM_CONFIG_DIR,
    $env:LUNARVIM_CACHE_DIR
)

function __add_separator($div_width) {
    "-" * $div_width
    Write-Output ""
}

function msg($text){
    Write-Output $text
    __add_separator "80"
}

function main($cliargs) {

    print_logo

    verify_lvim_dirs

    if ($cliargs.Contains("--overwrite")) {
        Write-Output "!!Warning!! -> Removing all lunarvim related config because of the --overwrite flag"
        $answer = Read-Host "Would you like to continue? [y]es or [n]o "
        if ("$answer" -ne "y" -and "$answer" -ne "Y") {
            exit 1
        }
        uninstall_lvim
    }
    if ($cliargs.Contains("--local") -or $cliargs.Contains("--testing")) {
        msg "Using local LunarVim installation"
        local_install
        exit
    }

    msg "Checking dependencies.."
    check_system_deps

    $answer = Read-Host "Would you like to check lunarvim's NodeJS dependencies? [y]es or [n]o (default: no) "
    if ("$answer" -eq "y" -or "$answer" -eq "Y") {
        install_nodejs_deps
    }

    $answer = Read-Host "Would you like to check lunarvim's Python dependencies? [y]es or [n]o (default: no) "
    if ("$answer" -eq "y" -or "$answer" -eq "Y") {
        install_python_deps
    }


    if (Test-Path "$env:LUNARVIM_BASE_DIR\init.lua" ) {
        msg "Updating LunarVim"
        validate_lunarvim_files
    }
    else {
        msg "Cloning Lunarvim"
        clone_lvim
        setup_lvim
    }
}

function print_missing_dep_msg($dep) {
    Write-Output "[ERROR]: Unable to find dependency [$dep]"
    Write-Output "Please install it first and re-run the installer."
}

$winget_package_matrix=@{"git" = "Git.Git"; "nvim" = "Neovim.Neovim"; "make" = "GnuWin32.Make"; "node" = "OpenJS.NodeJS"; "pip" = "Python.Python.3"}
$scoop_package_matrix=@{"git" = "git"; "nvim" = "neovim-nightly"; "make" = "make"; "node" = "nodejs"; "pip" = "python3"}

function install_system_package($dep) {
    if (Get-Command -Name "winget" -ErrorAction SilentlyContinue) {
        Write-Output "Attempting to install dependency [$dep] with winget"
        $install_cmd = "winget install --interactive $winget_package_matrix[$dep]"
    }
    elseif (Get-Command -Name "scoop" -ErrorAction SilentlyContinue) {
        Write-Output "Attempting to install dependency [$dep] with scoop"
        # TODO: check if it's fine to not run it with --global
        $install_cmd = "scoop install $scoop_package_matrix[$dep]"
    }
    else {
        print_missing_dep_msg "$dep"
        exit 1
    }

    try {
        Invoke-Command $install_cmd -ErrorAction Stop
    }
    catch {
        print_missing_dep_msg "$dep"
        exit 1
    }
}

function check_system_dep($dep) {
    try {
        Get-Command -Name $dep -ErrorAction Stop | Out-Null
    }
    catch {
        install_system_package "$dep"
    }
}

function check_system_deps() {
    check_system_dep "git"
    check_system_dep "nvim"
    check_system_dep "make"
}

function install_nodejs_deps() {
    $dep = "node"
    try {
        check_system_dep "$dep"
        Invoke-Command -ScriptBlock { npm install --global neovim tree-sitter-cli } -ErrorAction Break
    }
    catch {
        print_missing_dep_msg "$dep"
    }
}

function install_python_deps() {
    $dep = "pip"
    try {
        check_system_dep "$dep"
        Invoke-Command -ScriptBlock { python -m pip install --user pynvim } -ErrorAction Break
    }
    catch {
        print_missing_dep_msg "$dep"
    }
}

function backup_old_config() {
    $src = "$env:LUNARVIM_CONFIG_DIR"
    if (Test-Path $src) {
        New-Item "$src.old" -ItemType Directory -Force | Out-Null
        Copy-Item -Force -Recurse "$src\*" "$src.old\." | Out-Null
    }
    msg "Backup operation complete"
}


function local_install() {
    verify_lvim_dirs
    $repoDir = git rev-parse --show-toplevel
    $gitLocalCloneCmd = git clone --progress "$repoDir" "$env:LUNARVIM_BASE_DIR"
    Invoke-Command -ErrorAction Stop -ScriptBlock { $gitLocalCloneCmd; setup_lvim }
}

function clone_lvim() {
    try {
        $gitCloneCmd = git clone --progress --depth 1 --branch "$LV_BRANCH" `
                "https://github.com/$LV_REMOTE" `
                "$env:LUNARVIM_BASE_DIR"
        Invoke-Command -ErrorAction Stop -ScriptBlock { $gitCloneCmd }
    }
    catch {
        msg "Failed to clone repository. Installation failed."
        exit 1		
    }
}

function setup_shim() {
    if ((Test-Path "$INSTALL_PREFIX\bin") -eq $false) {
        New-Item "$INSTALL_PREFIX\bin" -ItemType Directory | Out-Null
    }

    Copy-Item -Force "$env:LUNARVIM_BASE_DIR\utils\bin\lvim.ps1" "$INSTALL_PREFIX\bin\lvim.ps1"
}

function uninstall_lvim() {
    foreach ($dir in $__lvim_dirs) {
        if (Test-Path "$dir") {
            Remove-Item -Force -Recurse "$dir"
        }
    }
}

function verify_lvim_dirs() {
    foreach ($dir in $__lvim_dirs) {
        if ((Test-Path "$dir") -eq $false) {
            New-Item "$dir" -ItemType Directory | Out-Null
        }
    }
    backup_old_config
}


function setup_lvim() {
    msg "Installing LunarVim shim"
    setup_shim

    msg "Installing sample configuration"

    if (Test-Path "$env:LUNARVIM_CONFIG_DIR\config.lua") {
        Move-Item "$env:LUNARVIM_CONFIG_DIR\config.lua" "$env:LUNARVIM_CONFIG_DIR\config.lua.old"
    }

    New-Item -ItemType File -Path "$env:LUNARVIM_CONFIG_DIR\config.lua" | Out-Null

    $exampleConfig = "$env:LUNARVIM_BASE_DIR\utils\installer\config_win.example.lua"
    Copy-Item -Force "$exampleConfig" "$env:LUNARVIM_CONFIG_DIR\config.lua"

    Write-Host "Make sure to run `:PackerSync` at first launch" -ForegroundColor Green

    create_alias

    msg "Thank you for installing LunarVim!!"

    Write-Output "You can start it by running: $INSTALL_PREFIX\bin\lvim.ps1"
    Write-Output "Do not forget to use a font with glyphs (icons) support [https://github.com/ryanoasis/nerd-fonts]"
}


function validate_lunarvim_files() {
    Set-Alias lvim "$INSTALL_PREFIX\bin\lvim.ps1"
    try {
        $verify_version_cmd='if v:errmsg != "" | cquit | else | quit | endif'
        Invoke-Command -ScriptBlock { lvim --headless -c 'LvimUpdate' -c "$verify_version_cmd" } -ErrorAction SilentlyContinue
    }
    catch {
        Write-Output "Unable to guarantee data integrity while updating. Please run `:LvimUpdate` manually instead."
        exit 1
    }
    Write-Output "Your LunarVim installation is now up to date!"
}

function create_alias {
    try {
        $answer = Read-Host $(`
                "Would you like to create an alias inside your Powershell profile?`n" + `
                "(This enables you to start lvim with the command 'lvim') [y]es or [n]o (default: no)" )
    }
    catch {
        msg "Non-interactive mode detected. Skipping alias creation"
        return
    }

    if ("$answer" -ne "y" -or "$answer" -ne "Y") {
        return
    }

    $lvim_bin="$INSTALL_PREFIX\bin\lvim.ps1"
    $lvim_alias = Get-Alias lvim -ErrorAction SilentlyContinue

    if ($lvim_alias.Definition -eq $lvim_bin) {
        Write-Output "Alias is already set and will not be reset."
        return
    }

    Add-Content -Path $PROFILE -Value $("`r`nSet-Alias lvim $lvim_bin")

    Write-Host 'To use the new alias in this window reload your profile with: `. $PROFILE`' -ForegroundColor Green
}

function print_logo(){
    Write-Output "

		88\                                                   88\               
		88 |                                                  \__|              
		88 |88\   88\ 888888$\   888888\   888888\ 88\    88\ 88\ 888888\8888\  
		88 |88 |  88 |88  __88\  \____88\ 88  __88\\88\  88  |88 |88  _88  _88\ 
		88 |88 |  88 |88 |  88 | 888888$ |88 |  \__|\88\88  / 88 |88 / 88 / 88 |
		88 |88 |  88 |88 |  88 |88  __88 |88 |       \88$  /  88 |88 | 88 | 88 |
		88 |\888888  |88 |  88 |\888888$ |88 |        \$  /   88 |88 | 88 | 88 |
		\__| \______/ \__|  \__| \_______|\__|         \_/    \__|\__| \__| \__|

  "
}

main "$args"

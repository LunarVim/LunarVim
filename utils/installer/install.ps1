#Requires -Version 7.1
$ErrorActionPreference = "Stop" # exit when command fails

# set script variables
$LV_BRANCH = ($LV_BRANCH, "rolling", 1 -ne $null)[0]
$LV_REMOTE = ($LV_REMOTE, "lunarvim/lunarvim.git", 1 -ne $null)[0]
$INSTALL_PREFIX = ($INSTALL_PREFIX, "$HOME\.local", 1 -ne $null)[0]

$env:XDG_DATA_HOME = ($env:XDG_DATA_HOME, "$env:APPDATA", 1 -ne $null)[0]
$env:XDG_CONFIG_HOME = ($env:XDG_CONFIG_HOME, "$env:LOCALAPPDATA", 1 -ne $null)[0]
$env:XDG_CACHE_HOME = ($env:XDG_CACHE_HOME, "$env:TEMP", 1 -ne $null)[0]
$env:LUNARVIM_RUNTIME_DIR = ($env:LUNARVIM_RUNTIME_DIR, "$env:XDG_DATA_HOME\lunarvim", 1 -ne $null)[0]
$env:LUNARVIM_CONFIG_DIR = ($env:LUNARVIM_CONFIG_DIR, "$env:XDG_CONFIG_HOME\lvim", 1 -ne $null)[0]
$env:LUNARVIM_CACHE_DIR = ($env:LUNARVIM_CACHE_DIR, "$env:XDG_CACHE_HOME\lvim", 1 -ne $null)[0]


$__lvim_dirs = (
    "$env:LUNARVIM_CONFIG_DIR",
    "$env:LUNARVIM_RUNTIME_DIR",
    "$env:LUNARVIM_CACHE_DIR"
)

function main($cliargs) {
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
  
    __add_separator "80"
  
    # skip this in a Github workflow
    if ( $null -eq "$GITHUB_ACTIONS" ) {
        install_packer
        setup_shim
        exit
    }

    __add_separator "80"

    check_system_deps

    Write-Output "Would you like to check lunarvim's NodeJS dependencies?"
    $answer = Read-Host "[y]es or [n]o (default: no) "
    if ("$answer" -eq "y" -or "$answer" -eq "Y") {
        install_nodejs_deps
    } 

    Write-Output "Would you like to check lunarvim's Python dependencies?"
    $answer = Read-Host "[y]es or [n]o (default: no) "
    if ("$answer" -eq "y" -or "$answer" -eq "Y") {
        install_python_deps
    } 

    __add_separator "80"

    Write-Output "Backing up old LunarVim configuration"
    backup_old_config

    __add_separator "80" 
 
    verify_lvim_dirs
  
    if (Test-Path "$env:LUNARVIM_RUNTIME_DIR\site\pack\packer\start\packer.nvim") {
        Write-Output "Packer already installed"
    }
    else {
        install_packer
    }
  
    __add_separator "80"
  
    if (Test-Path "$env:LUNARVIM_RUNTIME_DIR\lvim\init.lua" ) {
        Write-Output "Updating LunarVim"
        update_lvim
    }
    else {
        if ($cliargs.Contains("--testing")) {
            copy_local_lvim_repository
        }
        else {
            clone_lvim
        }
        setup_lvim
    }
  
    __add_separator "80"
}

function print_missing_dep_msg($dep) {
    Write-Output "[ERROR]: Unable to find dependency [$dep]"
    Write-Output "Please install it first and re-run the installer. Try: $RECOMMEND_INSTALL $dep"
}

function install_system_package($dep) {
    if (Get-Command -Name "winget" -ErrorAction SilentlyContinue) {
        Write-Output "[INFO]: Attempting to install dependency [$dep] with winget"
        $install_cmd = "winget install --interactive"
    }
    elseif (Get-Command -Name "scoop" -ErrorAction SilentlyContinue) {
        Write-Output "[INFO]: Attempting to install dependency [$dep] with scoop"
        # TODO: check if it's fine to not run it with --global
        $install_cmd = "scoop install"
    }
    else {
        print_missing_dep_msg "$dep"
        exit 1
    }

    try {
        Invoke-Command $install_cmd $dep -ErrorAction Stop
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
    Write-Output "[INFO]: Checking dependencies.."
    check_system_dep "git"
    check_system_dep "nvim"
	
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
    foreach ($dir in $__lvim_dirs) {
        # we create an empty folder for subsequent commands \
        # that require an existing directory	 
        if ( Test-Path "$dir") {
            New-Item "$dir.bak" -ItemType Directory -Force
            Copy-Item -Recurse "$dir\*" "$dir.bak\."
        }
    }

    Write-Output "Backup operation complete"
}


function install_packer() {
    Invoke-Command -ErrorAction Stop -ScriptBlock { git clone --progress --depth 1 "https://github.com/wbthomason/packer.nvim" "$env:LUNARVIM_RUNTIME_DIR\site\pack\packer\start\packer.nvim" }
}
  
function copy_local_lvim_repository() {
    Write-Output "Copy local LunarVim configuration"
    Copy-Item -Path "$((Get-Item $PWD).Parent.Parent.FullName)" -Destination "$env:LUNARVIM_RUNTIME_DIR/lvim" -Recurse
}

function clone_lvim() {
    Write-Output "Cloning LunarVim configuration"
    try {
        Invoke-Command -ErrorAction Stop -ScriptBlock { git clone --progress --branch "$LV_BRANCH" --depth 1 "https://github.com/$LV_REMOTE" "$env:LUNARVIM_RUNTIME_DIR/lvim" } 
    }
    catch {
        Write-Output "Failed to clone repository. Installation failed."
        exit 1		
    }
}

function setup_shim() {
    if ((Test-Path "$INSTALL_PREFIX\bin") -eq $false) {
        New-Item "$INSTALL_PREFIX\bin" -ItemType Directory
    }
    Copy-Item "$env:LUNARVIM_RUNTIME_DIR\lvim\utils\bin\lvim.ps1" -Destination "$INSTALL_PREFIX\bin\lvim.ps1" -Force
}

function verify_lvim_dirs() {
    if ($cliargs.Contains("--overwrite")) {
        Write-Output "!!Warning!! -> Removing all lunarvim related config because of the --overwrite flag"
        $answer = Read-Host "Would you like to continue? [y]es or [n]o "
        if ("$answer" -ne "y" -and "$answer" -ne "Y") {
            exit 1
        } 

        foreach ($dir in $__lvim_dirs) {
            if (Test-Path "$dir") {
                Remove-Item -Force -Recurse "$dir"
            }
        }
    }

    foreach ($dir in $__lvim_dirs) {
        if ((Test-Path "$dir") -eq $false) {
            New-Item "$dir" -ItemType Directory
        }
    }

}

function setup_lvim() {
    Write-Output "Installing LunarVim shim"
  
    setup_shim
  
    Write-Output "Preparing Packer setup"

    if (Test-Path "$env:LUNARVIM_CONFIG_DIR\config.lua") {
        Remove-Item -Force "$env:LUNARVIM_CONFIG_DIR\config.lua"
    }

    Out-File -FilePath "$env:LUNARVIM_CONFIG_DIR\config.lua"
  
    Write-Output "Packer setup complete"
	
    __add_separator "80"

    Copy-Item "$env:LUNARVIM_RUNTIME_DIR\lvim\utils\installer\config.example.lua" "$env:LUNARVIM_CONFIG_DIR\config.lua"
  
    $answer = Read-Host $(`
            "Would you like to create an alias inside your Powershell profile?`n" + `
            "(This enables you to start lvim with the command 'lvim') [y]es or [n]o (default: no)" )
    if ("$answer" -eq "y" -and "$answer" -eq "Y") {
        create_alias
    } 

    __add_separator "80"

    Write-Output "Thank you for installing LunarVim!!"
    Write-Output "You can start it by running: $INSTALL_PREFIX\bin\lvim.ps1"
    Write-Output "Do not forget to use a font with glyphs (icons) support [https://github.com/ryanoasis/nerd-fonts]"
}


function update_lvim() {
    try {
        Invoke-Command git -C "$env:LUNARVIM_RUNTIME_DIR/lvim" status -uno
    }
    catch {
        git -C "$env:LUNARVIM_RUNTIME_DIR/lvim" pull --ff-only --progress -or
        Write-Output "Unable to guarantee data integrity while updating. Please do that manually instead."
        exit 1
    }
    Write-Output "Your LunarVim installation is now up to date!"
}

function __add_separator($div_width) {
    "-" * $div_width
    Write-Output ""
}

function create_alias {
    if ($null -eq $(Get-Alias | Select-String "lvim")) {
        Add-Content -Path $PROFILE -Value $( -join @('Set-Alias lvim "', "$INSTALL_PREFIX", '\bin\lvim.ps1"'))
		
        Write-Output ""
        Write-Host 'To use the new alias in this window reload your profile with ". $PROFILE".' -ForegroundColor Yellow

    }
    else {
        Write-Output "Alias is already set and will not be reset."
    }
}

main "$args"

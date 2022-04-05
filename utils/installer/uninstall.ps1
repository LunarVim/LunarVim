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

function main($cliargs) {
    Write-Output "Removing LunarVim binary..."
    remove_lvim_bin
    Write-Output "Removing LunarVim directories..."
    $force = $false
    if ($cliargs.Contains("--remove-backups")) {
        $force = $true
    }
    remove_lvim_dirs $force
    Write-Output "Uninstalled LunarVim!"
}

function remove_lvim_bin(){
    $lvim_bin="$INSTALL_PREFIX\bin\lvim"
    if (Test-Path $lvim_bin) {
        Remove-Item -Force $lvim_bin
    }
    if (Test-Path alias:lvim) {
        Write-Warning "Please make sure to remove the 'lvim' alias from your `$PROFILE`: $PROFILE"
    }
}

function remove_lvim_dirs($force) {
    foreach ($dir in $__lvim_dirs) {
        if (Test-Path $dir) {
            Remove-Item -Force -Recurse $dir
        }
        if ($force -eq $true) {
            if (Test-Path "$dir.bak") {
                Remove-Item -Force -Recurse "$dir.bak"
            }
            if (Test-Path "$dir.old") {
                Remove-Item -Force -Recurse "$dir.old"
            }
        }
    }
}

main($args)
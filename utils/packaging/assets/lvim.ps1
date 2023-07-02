#Requires -Version 5
$ErrorActionPreference = "Stop"

function SetEnv()
{
  param($name, $value)
  if ( -Not (Test-Path env:$name))
  {
    New-Item env:$name -Value $value | Out-Null
  }
}

SetEnv XDG_DATA_HOME $env:APPDATA
SetEnv XDG_CONFIG_HOME $env:LOCALAPPDATA
SetEnv XDG_CACHE_HOME $env:TEMP

SetEnv LUNARVIM_RUNTIME_DIR "$env:XDG_DATA_HOME\lunarvim"
SetEnv LUNARVIM_CONFIG_DIR "$env:XDG_CONFIG_HOME\lvim"
SetEnv LUNARVIM_CACHE_DIR "$env:XDG_CACHE_HOME\lvim"
SetEnv NVIM_APPNAME "lvim"

SetEnv LUNARVIM_BASE_DIR $(Resolve-Path "$PSScriptRoot\..\CMAKE_INSTALL_DATAROOTDIR\lunarvim")

nvim -u "$env:LUNARVIM_BASE_DIR\init.lua" @args

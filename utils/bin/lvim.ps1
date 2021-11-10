$env:XDG_DATA_HOME = ($env:XDG_DATA_HOME, "$env:APPDATA", 1 -ne $null)[0]
$env:XDG_CONFIG_HOME = ($env:XDG_CONFIG_HOME, "$env:LOCALAPPDATA", 1 -ne $null)[0]
$env:XDG_CACHE_HOME = ($env:XDG_CACHE_HOME, "$env:TEMP", 1 -ne $null)[0]

$env:LUNARVIM_RUNTIME_DIR = ($env:LUNARVIM_RUNTIME_DIR, "$env:XDG_DATA_HOME\lunarvim", 1 -ne $null)[0]
$env:LUNARVIM_CONFIG_DIR = ($env:LUNARVIM_CONFIG_DIR, "$env:XDG_CONFIG_HOME\lvim", 1 -ne $null)[0]
$env:LUNARVIM_CACHE_DIR = ($env:LUNARVIM_CACHE_DIR, "$env:XDG_CACHE_HOME\lvim", 1 -ne $null)[0]

nvim -u "$env:LUNARVIM_RUNTIME_DIR\lvim\init.lua" @args

# set script variables
$XDG_CONFIG_HOME="$HOME\.config"
$XDG_DATA_HOME="$HOME\.local\share"
$XDG_CACHE_HOME=$env:TEMP

# Set Variable to master if not set differently
if ($null -eq $LVBRANCH) {
    $LVBRANCH = "master"
}

$ErrorActionPreference = "Stop" # exit when command fails

function mkdirOnDemand($path) {
	if ((Test-Path $path) -eq $false) {
		mkdir $path
	}
}

function verifyInstalled($cmd){
	try { Get-Command -Name $cmd -ErrorAction Stop | Out-Null }
	catch { "Error! command [$cmd] is not found, please install and try again." }
}

function moveOldLvim {
	Write-Output "Not installing LunarVim"
	Write-Output "Please move your $XDG_DATA_HOME\lunarvim folder before installing"
	exit
}

function installPynvim {
	Write-Output "Installing pynvim..."
	pip3.exe install pynvim --user
}

function installPacker {
	git clone "https://github.com/wbthomason/packer.nvim" "$XDG_DATA_HOME\lunarvim\site\pack\packer\start\packer.nvim"
}

function modifyHomeVar($config) {
	
	Copy-Item $config $config".save"
	(Get-Content -Path $config) |
		ForEach-Object {$_ -Replace 'os.getenv "HOME"', 'os.getenv "HOMEDRIVE" .. os.getenv "HOMEPATH"'} |
			Set-Content -Path $config
}

function cloneConfig($arg) {
	Write-Output "Cloning LunarVim configuration"
	mkdirOnDemand("$XDG_DATA_HOME\lunarvim")
	
	if ($arg.Contains("--testing")) {
		Copy-Item -Recurse "$pwd" "$XDG_DATA_HOME\lunarvim\lvim"
	} else {
		Write-Output "lvbranch=$LVBRANCH"
		git clone --branch "$LVBRANCH" "https://github.com/LunarVim/LunarVim.git" "$XDG_DATA_HOME\lunarvim\lvim"
	}

	mkdirOnDemand("$XDG_CONFIG_HOME\lvim")
	
	if (($env:Path.Contains("$XDG_DATA_HOME\lunarvim\lvim\utils\bin\")) -eq $false) {
		$env:Path += ";$XDG_DATA_HOME\lunarvim\lvim\utils\bin\"
		[Environment]::SetEnvironmentVariable("Path", $env:Path, [System.EnvironmentVariableTarget]::User)
	}
	
	# Hack because in rolling branch lv-config.lua is renamed to config.lua
	if ($LVBRANCH -eq "rolling") {
		Copy-Item "$XDG_DATA_HOME\lunarvim\lvim\utils\installer\config.example-no-ts.lua" "$XDG_CONFIG_HOME\lvim\config.lua"
	} else {
		Copy-Item "$XDG_DATA_HOME\lunarvim\lvim\utils\installer\lv-config.example-no-ts.lua" "$XDG_CONFIG_HOME\lvim\lv-config.lua"
	}

	modifyHomeVar("$XDG_DATA_HOME\lunarvim\lvim\lua\default-config.lua")
	modifyHomeVar("$XDG_DATA_HOME\lunarvim\lvim\init.lua")

	nvim -u $XDG_DATA_HOME\lunarvim\lvim\init.lua --cmd "set runtimepath+=$XDG_DATA_HOME\lunarvim\lvim" --headless +'autocmd User PackerComplete sleep 100m | qall' +PackerInstall
	nvim -u $XDG_DATA_HOME\lunarvim\lvim\init.lua --cmd "set runtimepath+=$XDG_DATA_HOME\lunarvim\lvim" --headless +'autocmd User PackerComplete sleep 100m | qall' +PackerSync

	Write-Output ""
	Write-Output "Compile Complete"
	Write-Output ""

	if (Test-Path "$XDG_DATA_HOME\lunarvim\lvim\init.lua" -PathType Any) {
		Write-Output "lv-config already present"
	} else {
		if($LVBRANCH -eq "rolling") {
			Copy-Item "$XDG_DATA_HOME\lunarvim\lvim\utils\installer\config.example.lua" "$XDG_CONFIG_HOME\lvim\config.lua"
		} else {
			Copy-Item "$XDG_DATA_HOME\lunarvim\lvim\utils\installer\lv-config.example.lua" "$XDG_CONFIG_HOME\lvim\lv-config.lua"
		}
	}
}

function rewriteLvimForWindows {
	Set-Content "$XDG_DATA_HOME\lunarvim\lvim\utils\bin\lvim.ps1" "nvim -u `"$XDG_DATA_HOME\lunarvim\lvim\init.lua`" --cmd `"set runtimepath+=$XDG_DATA_HOME\lunarvim\lvim`" `"$args`""
}

# Welcome
Write-Output 'Installing LunarVim'
if ($args.Contains("--override")) {
    Write-Output '!!Warning!! -> Removing all lunarvim related config because of the --overwrite flag'
	Remove-Item -Recurse -Force "$XDG_DATA_HOME\lunarvim" -ErrorAction Ignore
	Remove-Item -Recurse -Force "$XDG_CACHE_HOME\nvim" -ErrorAction Ignore
	Remove-Item -Recurse -Force "$XDG_CONFIG_HOME\lvim" -ErrorAction Ignore
}

# move old lvim directory if it exists
if (Test-Path -Path "$XDG_DATA_HOME\lunarvim") { moveOldLvim }

# install pip
verifyInstalled("pip3.exe")
Write-Output "pip installed, moving on..."

# install node
verifyInstalled("node.exe")
Write-Output "node installed, moving on..."

# install pynvim
if ($null -ne (pip3.exe list | Select-String "pynvim")) { Write-Output "pynvim installed, moving on..." }
else { installPynvim }

if ((Test-Path "$XDG_DATA_HOME\lunarvim\site\pack\packer\start\packer.nvim" -PathType Any)) {
	Write-Output "packer already installed"
} else {
	installPacker
}

if ((Test-Path "$XDG_DATA_HOME\lunarvim\lvim\init.lua" -PathType Any)) {
	Write-Output "LunarVim already installed"
} else {
	# clone config down
	cloneConfig($args)
}

rewriteLvimForWindows

Write-Output "I recommend you also install and activate a font from here: https://github.com/ryanoasis/nerd-fonts"

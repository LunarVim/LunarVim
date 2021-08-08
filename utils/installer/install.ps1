#Set Variable to master is not set differently
if ($null -eq $LVBRANCH) {
    $LVBRANCH = "master"
}

#set -o nounset # error when referencing undefined variable
$ErrorActionPreference = "Stop" # exit when command fails

function mkdirondemand($path) {
	if ((Test-Path $path) -eq $false) {
		mkdir $path
	}
}

function commandinstalled($cmd){
	try { Get-Command $cmd > $null }
	catch { return $false }
	return $true
}

function moveoldlvim {
	Write-Output "Not installing LunarVim"
	Write-Output "Please move your $HOME\.local\share\lunarvim folder before installing"
	exit
}

function asktoinstallpip {
	Write-Output "Please install pip3 before continuing with install"
	exit
}

function installnode {
	if ((commandinstalled("winget.exe")) -eq $false) {
		Write-Output "winget is not installed, but is the only package manager currently supported."
		Write-Output "node is not installed. Please install it manually"
		exit
	}
	winget.exe install "OpenJS.NodeJSLTS"
}

function asktoinstallnode {
	Write-Output "node not found"
	$answer = Read-Host "Would you like to install node now (y/n)" -Confirm
	if($answer.ToLower() -eq 'y') {
		installnode
	}
}

function installpynvim {
	Write-Output "Installing pynvim..."
	pip3.exe install pynvim --user
}

function installpacker {
	git clone https://github.com/wbthomason/packer.nvim ${HOME}/.local/share/lunarvim/site/pack/packer/start/packer.nvim
}

function modifyhomevar($config) {
	
	Copy-Item $config $config".save"
	(Get-Content -Path $config) |
		ForEach-Object {$_ -Replace 'os.getenv "HOME"', 'os.getenv "HOMEDRIVE" .. os.getenv "HOMEPATH"'} |
			Set-Content -Path $config
}

function cloneconfig($arg) {
	Write-Output "Cloning LunarVim configuration"
	mkdirondemand("$HOME/.local/share/lunarvim")
	
	if ($arg.Contains("--testing")) {
		Copy-Item -Recurse "${pwd}" "$HOME/.local/share/lunarvim/lvim"
	} else {
		Write-Output "lvbranch=$LVBRANCH"
		git clone --branch "$LVBRANCH" https://github.com/ChristianChiarulli/lunarvim.git "$HOME/.local/share/lunarvim/lvim"
	}

	mkdirondemand("$HOME/.config/lvim")
	
	if (($env:Path.Contains("$HOME/.local/share/lunarvim/lvim/utils/bin/")) -eq $false) {
		$env:Path += ";$HOME/.local/share/lunarvim/lvim/utils/bin/"
		[Environment]::SetEnvironmentVariable("Path", $env:Path, [System.EnvironmentVariableTarget]::User)
	}
	
	# Hack because in rolling branch lv-config.lua is renamed to config.lua
	if ($LVBRANCH -eq "rolling") {
		Copy-Item "$HOME/.local/share/lunarvim/lvim/utils/installer/config.example-no-ts.lua" "$HOME/.config/lvim/config.lua"
	} else {
		Copy-Item "$HOME/.local/share/lunarvim/lvim/utils/installer/lv-config.example-no-ts.lua" "$HOME/.config/lvim/lv-config.lua"
	}

	modifyhomevar("$HOME/.local/share/lunarvim/lvim/lua/default-config.lua")
	modifyhomevar("$HOME/.local/share/lunarvim/lvim/init.lua")

	nvim -u $HOME/.local/share/lunarvim/lvim/init.lua --cmd "set runtimepath+=$HOME/.local/share/lunarvim/lvim" --headless +'autocmd User PackerComplete sleep 100m | qall' +PackerInstall
	nvim -u $HOME/.local/share/lunarvim/lvim/init.lua --cmd "set runtimepath+=$HOME/.local/share/lunarvim/lvim" --headless +'autocmd User PackerComplete sleep 100m | qall' +PackerSync

	Write-Output ""
	Write-Output "Compile Complete"
	Write-Output ""

	if (Test-Path "$HOME/.local/share/lunarvim/lvim/init.lua" -PathType Any) {
		Write-Output "lv-config already present"
	} else {
		if($LVBRANCH -eq "rolling") {
			Copy-Item "$HOME/.local/share/lunarvim/lvim/utils/installer/config.example.lua" "$HOME/.config/lvim/config.lua"
		} else {
			Copy-Item "$HOME/.local/share/lunarvim/lvim/utils/installer/lv-config.example.lua" "$HOME/.config/lvim/lv-config.lua"
		}
	}
}

function rewritelvimforwindows {
	Set-Content "$HOME/.local/share/lunarvim/lvim/utils/bin/lvim.ps1" 'nvim -u "$HOME/.local/share/lunarvim/lvim/init.lua" --cmd "set runtimepath+=$HOME/.local/share/lunarvim/lvim" "$args"'
}

# Welcome
Write-Output 'Installing LunarVim'
if ($args.Contains("--override")) {
    Write-Output '!!Warning!! -> Removing all lunarvim related config because of the --overwrite flag'
	Remove-Item -Recurse -Force "$HOME/.local/share/lunarvim" -ErrorAction Ignore
	Remove-Item -Recurse -Force "$HOME/.cache/nvim" -ErrorAction Ignore
	Remove-Item -Recurse -Force "$HOME/.config/lvim" -ErrorAction Ignore
}

# move old lvim directory if it exists
if (Test-Path -Path "$HOME/.local/share/lunarvim") { moveoldlvim }

# install pip
if (commandinstalled("pip3.exe")){ Write-Output "pip installed, moving on..." } 
else { asktoinstallpip }

# install node
if (commandinstalled("node.exe")) { Write-Output "node installed, moving on..." }
else { asktoinstallnode }

# install pynvim
if ($null -ne (pip3.exe list | Select-String "pynvim")) { Write-Output "pynvim installed, moving on..." }
else { installpynvim }

if ((Test-Path "$HOME/.local/share/lunarvim/site/pack/packer/start/packer.nvim" -PathType Any)) {
	Write-Output "packer already installed"
} else {
	installpacker
}

if ((Test-Path "$HOME/.local/share/lunarvim/lvim/init.lua" -PathType Any)) {
	Write-Output "LunarVim already installed"
} else {
	# clone config down
	cloneconfig($args)
}

rewritelvimforwindows

Write-Output "I recommend you also install and activate a font from here: https://github.com/ryanoasis/nerd-fonts"

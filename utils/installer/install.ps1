$ErrorActionPreference = "Stop" # exit when command fails

# set script variables
$LV_BRANCH = ($LV_BRANCH, "rolling", 1 -ne $null)[0]
$LV_REMOTE = ($LV_REMOTE, "lunarvim/lunarvim.git", 1 -ne $null)[0]
$INSTALL_PREFIX = ($INSTALL_PREFIX, "$HOME\.local", 1 -ne $null)[0]

$XDG_DATA_HOME = ($XDG_DATA_HOME, "$HOME\.local\share", 1 -ne $null)[0]
$XDG_CACHE_HOME = ($XDG_CACHE_HOME, "$HOME\.cache", 1 -ne $null)[0]
$XDG_CONFIG_HOME = ($XDG_CONFIG_HOME, "$HOME\.config", 1 -ne $null)[0]

$NEOVIM_CACHE_DIR = "$XDG_CACHE_HOME\nvim"


$LUNARVIM_RUNTIME_DIR = ($LUNARVIM_RUNTIME_DIR, "$XDG_DATA_HOME\lunarvim", 1 -ne $null)[0]
$LUNARVIM_CONFIG_DIR = ($LUNARVIM_CONFIG_DIR, "$XDG_CONFIG_HOME\lvim", 1 -ne $null)[0]

$__lvim_dirs = (
	"$LUNARVIM_CONFIG_DIR",
	"$LUNARVIM_RUNTIME_DIR",
	"$NEOVIM_CACHE_DIR" # for now this is shared with neovim
)

$__npm_deps = (
	"neovim",
	"tree-sitter-cli"
)

$__pip_deps = (
	"pynvim"
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
		check_system_deps
  
		__add_separator "80"

		<# Write-Output "Would you like to check lunarvim's NodeJS dependencies?"
		$answer = Read-Host "[y]es or [n]o (default: no) "
		if ("$answer" -eq "y" -or "$answer" -eq "Y") {
			install_nodejs_deps
		} 
  
		Write-Output "Would you like to check lunarvim's Python dependencies?"
		$answer = Read-Host "[y]es or [n]o (default: no) "
		if ("$answer" -eq "y" -or "$answer" -eq "Y") {
			install_python_deps
		} 
	    
		Write-Output "Would you like to check lunarvim's Rust dependencies?"
		$answer = Read-Host "[y]es or [n]o (default: no) "
		if ("$answer" -eq "y" -or "$answer" -eq "Y") {
			install_rust_deps
		} 
  
		__add_separator "80"
  
		Write-Output "Backing up old LunarVim configuration"
		backup_old_config
  
		__add_separator "80" #>
  
	}
  
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
  
	if (Test-Path "$LUNARVIM_RUNTIME_DIR\site\pack\packer\start\packer.nvim") {
		Write-Output "Packer already installed"
	}
	else {
		install_packer
	}
  
	__add_separator "80"
  
	if (Test-Path "$LUNARVIM_RUNTIME_DIR\lvim\init.lua" ) {
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
  

function check_dep($dep) {
	try { 
		Get-Command -Name $dep -ErrorAction Stop | Out-Null 
	}
	catch { 
		print_missing_dep_msg $dep
		exit 1
	}
}

function check_system_deps() {
	check_dep "git"
	check_dep "nvim"
}

function backup_old_config() {
	foreach ($dir in $__lvim_dirs) {
		# we create an empty folder for subsequent commands \
		# that require an existing directory	  
		New-Item "$dir.bak" -ItemType "directory"
		Copy-Item -Recurse "$dir\*" "$dir.bak\."
	}

	Write-Output "Backup operation complete"
}


function install_packer() {
	git clone --progress --depth 1 "https://github.com/wbthomason/packer.nvim" "$LUNARVIM_RUNTIME_DIR\site\pack\packer\start\packer.nvim"
}
  
function copy_local_lvim_repository() {
	Write-Output "Copy local LunarVim configuration"
	Copy-Item -Path "$((Get-Item $PWD).Parent.Parent.FullName)" -Destination "$LUNARVIM_RUNTIME_DIR/lvim" -Recurse
}

function clone_lvim() {
	Write-Output "Cloning LunarVim configuration"
	try {
		git clone --progress --branch "$LV_BRANCH" --depth 1 "https://github.com/${LV_REMOTE}" "$LUNARVIM_RUNTIME_DIR/lvim" 
	}
	catch {
		Write-Output "Failed to clone repository. Installation failed."
		exit 1		
	}
}

function setup_shim() {
	if ((Test-Path "$INSTALL_PREFIX\bin") -eq $false) {
		New-Item "$INSTALL_PREFIX\bin" -ItemType "directory"
	}

	Set-Content -Path "$INSTALL_PREFIX\bin\lvim.ps1" ("
		New-Variable -Name LUNARVIM_CONFIG_DIR -Value '$LUNARVIM_CONFIG_DIR'
		New-Variable -Name LUNARVIM_RUNTIME_DIR -Value '$LUNARVIM_RUNTIME_DIR'
		
		nvim -u '$LUNARVIM_RUNTIME_DIR\lvim\init.lua' ", '"', "$args", '"')
}

function setup_lvim() {
	Write-Output "Installing LunarVim shim"
  
	setup_shim
  
	Write-Output "Preparing Packer setup"

	if ((Test-Path "$LUNARVIM_CONFIG_DIR") -eq $false) {
		New-Item "$LUNARVIM_CONFIG_DIR" -ItemType "directory"
	}

	Copy-Item "$LUNARVIM_RUNTIME_DIR\lvim\utils\installer\config.example-no-ts.lua" `
		"$LUNARVIM_CONFIG_DIR\config.lua"
  
	nvim -u "$LUNARVIM_RUNTIME_DIR\lvim\init.lua" -c 'autocmd User PackerComplete sleep 100m | qall' -c PackerInstall
	nvim -u "$LUNARVIM_RUNTIME_DIR\lvim\init.lua" -c 'autocmd User PackerComplete sleep 100m | qall' -c PackerSync
  
	Write-Output "Packer setup complete"
  
	Copy-Item "$LUNARVIM_RUNTIME_DIR\lvim\utils\installer\config.example.lua" "$LUNARVIM_CONFIG_DIR\config.lua"
  
	$answer = Read-Host "Would you like to create a shortcut for $INSTALL_PREFIX\bin\lvim.ps1? [y]es or [n]o "
	if ("$answer" -eq "y" -and "$answer" -eq "Y") {
		create_shortcut
	} 

	#append_to_path

	Write-Output "Thank you for installing LunarVim!!"
	Write-Output "You can start it by running: $INSTALL_PREFIX\bin\lvim.ps1"
	Write-Output "Do not forget to use a font with glyphs (icons) support [https://github.com/ryanoasis/nerd-fonts]"
}


function update_lvim() {
	try {
		git -C "$LUNARVIM_RUNTIME_DIR/lvim" status -uno
	}
	catch {
		git -C "$LUNARVIM_RUNTIME_DIR/lvim" pull --ff-only --progress -or
		Write-Output "Unable to guarantee data integrity while updating. Please do that manually instead."
		exit 1
	}
	Write-Output "Your LunarVim installation is now up to date!"
}

function __add_separator($div_width) {
	"-" * $div_width
	Write-Output ""
}

function create_shortcut {
	if(Test-Path "$INSTALL_PREFIX\bin\lvim") {
		Remove-Item "$INSTALL_PREFIX\bin\lvim"
	}
	$WshShell = New-Object -comObject WScript.Shell
	$Shortcut = $WshShell.CreateShortcut("$INSTALL_PREFIX\bin\lvim.lnk")
	$Shortcut.TargetPath = "$INSTALL_PREFIX\bin\lvim.ps1"
	$Shortcut.Save()
	Move-Item "$INSTALL_PREFIX\bin\lvim.lnk" "$INSTALL_PREFIX\bin\lvim"
}

# TODO needs elevation
function append_to_path {
	$registryPath = 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment'
	$path = (Get-ItemProperty -Path $registryPath -Name PATH).path
	$list = [System.Collections.ArrayList]::new()
	$list.AddRange(($path -split ";"))
	$containsPathAlready = $false
	foreach ($item in $list) {
		if($item -eq "$INSTALL_PREFIX\bin\lvim"){
			$containsPathAlready = $true
			break
		}
	}

	if (!$containsPathAlready) {
		Write-Output "Add $INSTALL_PREFIX\bin\lvim to PATH variable"
		$list.Add("$INSTALL_PREFIX\bin\lvim")
		$newPath = ($list -join ";")
		Set-ItemProperty -Path $registryPath -Name PATH -Value $newPath
	}
	
}

append_to_path
#main "$args"


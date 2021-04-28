$iswin = $PSVersionTable.Platform -match '^($|(Microsoft )?Win)'
if (!$iswin) {
    Write-Error "SolarVim is Windows Only! If you are looking for this for linux/macos check LunarVim"
    exit
}
Write-Host "Scoop is being installed"
if (!(Test-Path "$HOME\scoop\shims")) {
    $script = Invoke-WebRequest -Uri https://get.scoop.sh/ -UseBasicParsing
    Invoke-Expression $script
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 
}
scoop install nodejs python llvm
scoop bucket add versions
scoop install neovim-nightly
npm install -g neovim
pip install pynvim neovim-remote ueberzug --user
git clone https://github.com/wbthomason/packer.nvim $HOME/AppData/Local/nvim/site/pack/packer/start/packer.nvim
git clone https://github.com/irishgreencitrus/SolarVim.git $HOME/AppData/Local/nvim/
nvim -u $HOME/AppData/Local/nvim/init.lua +PackerInstall


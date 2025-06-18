@echo off

echo Installing Chocolatey..
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"



echo Installing Vim...
choco install Vim

echo Installing NeoVim...
choco install neovim

echo Installing Git...
choco install git -y

echo Installing Make...
choco install make -y

echo Installing Python...
choco install python -y

echo Installing Node.js and npm...
choco install nodejs -y

echo Installing Rust and Cargo...
choco install rust -y

echo Installation complete.

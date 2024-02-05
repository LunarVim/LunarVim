@echo off
setlocal enabledelayedexpansion

if not defined XDG_DATA_HOME set XDG_DATA_HOME=%APPDATA%
if not defined XDG_CONFIG_HOME set XDG_CONFIG_HOME=%LOCALAPPDATA%
if not defined XDG_CACHE_HOME set XDG_CACHE_HOME=%TEMP%

if not defined LUNARVIM_RUNTIME_DIR set LUNARVIM_RUNTIME_DIR=!XDG_DATA_HOME!\lunarvim
if not defined LUNARVIM_CONFIG_DIR set LUNARVIM_CONFIG_DIR=!XDG_CONFIG_HOME!\lvim
if not defined LUNARVIM_CACHE_DIR set LUNARVIM_CACHE_DIR=!XDG_CACHE_HOME!\lvim
if not defined LUNARVIM_BASE_DIR set LUNARVIM_BASE_DIR=!LUNARVIM_RUNTIME_DIR!\lvim

nvim -u "!LUNARVIM_BASE_DIR!\init.lua" %*

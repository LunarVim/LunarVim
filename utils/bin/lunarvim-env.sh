#!/bin/bash

# PREFIX:
#   Where to install lunarvim.
#
if [ -v GLOBAL ]; then
	PREFIX=${PREFIX:-/opt}
else
	PREFIX=${PREFIX:-$HOME/.config}
fi


# LV_BASE:
#   Path to the "base" lunarvim configuration (the global repo).
#
LV_BASE="${PREFIX}"
[ -v GLOBAL ] && LV_BASE=${LV_BASE}/lunarvim

LV_CONFIG_DIR=${LV_BASE}/nvim

# LV_USER:
#   Path to the "user" data/cache folders.
#
LV_USER="$HOME/.local/share/lunarvim"

# LV_USER_CONFIG:
#   Path to the "users" local config dir.
#
LV_USER_CONFIG="$HOME/.config/lunarvim"

# LV_BASE_CONFIG:
#   Path to the "base" config file.
#
LV_BASE_CONFIG=${LV_CONFIG_DIR}/init.lua

#
# Initialise the users lunarvim config if not already created.
#
if [ ! -f ${LV_USER_CONFIG}/nvim/nv-settings.lua ]; then
	LV_CONFIG_INIT=1
fi

#
# Force a PackerSync if lunarvim is updated, since the last run.
#
if [ -v GLOBAL ]; then
	if [ ${LV_BASE}/.packer_sync -nt ${LV_USER}/.packer_sync ] || [ ! -f ${LV_USER}/.packer_sync ]; then
		LV_SYNC=+PackerSync
		echo "Update required! ${LV_SYNC}"
	fi
fi

export SHELL=/bin/bash
export XDG_CONFIG_HOME=${LV_USER_CONFIG}
export XDG_DATA_HOME="${LV_USER}/data"
export XDG_CACHE_HOME="${LV_USER}/cache"
export XDG_CONFIG_DIRS="/usr/share:/usr/local/share:${LV_BASE}"


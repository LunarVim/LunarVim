#!/bin/bash

# PREFIX:
#   Where to install nvcode.
#
if [ -v GLOBAL ]; then
	PREFIX=${PREFIX:-/opt}
else
	PREFIX=${PREFIX:-$HOME/.config}
fi


# NVCODE_BASE:
#   Path to the "base" NVCode configuration (the global repo).
#
NVCODE_BASE="${PREFIX}"
[ -v GLOBAL ] && NVCODE_BASE=${NVCODE_BASE}/nvcode

NVCODE_CONFIG_DIR=${NVCODE_BASE}/nvim

# NVCODE_USER:
#   Path to the "user" data/cache folders.
#
NVCODE_USER="$HOME/.local/share/nvcode"

# NVCODE_USER_CONFIG:
#   Path to the "users" local config dir.
#
NVCODE_USER_CONFIG="$HOME/.config/nvcode"

# NVCODE_BASE_CONFIG: 
#   Path to the "base" config file.
#
NVCODE_BASE_CONFIG=${NVCODE_CONFIG_DIR}/init.lua

#
# Initialise the users nvcode config if not already created.
#
if [ ! -f ${NVCODE_USER_CONFIG}/nvim/nv-settings.lua ]; then
	NVCODE_CONFIG_INIT=1
fi

#
# Force a PackerSync if nvcode is updated, since the last run.
#
if [ -v GLOBAL ]; then
	if [ ${NVCODE_BASE}/.packer_sync -nt ${NVCODE_USER}/.packer_sync ] || [ ! -f ${NVCODE_USER}/.packer_sync ]; then
		NVCODE_SYNC=+PackerSync
		echo "Update required! ${NVCODE_SYNC}"
	fi
fi

export SHELL=/bin/bash
export XDG_CONFIG_HOME=${NVCODE_USER_CONFIG}
export XDG_DATA_HOME="${NVCODE_USER}/data"	
export XDG_CACHE_HOME="${NVCODE_USER}/cache"
export XDG_CONFIG_DIRS="/usr/share:/usr/local/share:${NVCODE_BASE}"


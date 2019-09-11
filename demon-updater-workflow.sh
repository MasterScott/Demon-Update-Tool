#!/usr/bin/env bash
# This is the workflow of the updater It will call scripts based on the version of Demon Linux
# 2019 - WeakNet Labs - Douglas Berdeaux, DemonLinux.com ^vv^
#
#SCRIPT=/usr/local/sbin/$(basename "$0") # this will be the full path to this script.
SCRIPT=$(basename "$0")
SCRIPT_CHECKSUM=$(md5sum $SCRIPT|awk '{print $1}') # This will generate an md5
source ~/.bashrc

log() {
  printf "[log]: $1 \n"
}
export -f log

if [[ "$1" != "$SCRIPT_CHECKSUM" ]] # ensure this file is not called alone, ity must be called with it's own checksum
  then
    log "Got SCRIPT_CHECKSUM: $SCRIPT_CHECKSUM"
    printf "\n[ERROR]: This script should not be called directly.\n\tPlease use the \"demon-updater.sh\" command\n\n"
    exit 1337
else
  printf "[i] Initializing update tool ...  \n"
  # 1. get current version
  # 2. get updates
  # 3. run them
fi

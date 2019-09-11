#!/usr/bin/env bash
# This is the workflow of the updater It will call scripts based on the version of Demon Linux
# 2019 - WeakNet Labs - Douglas Berdeaux, DemonLinux.com ^vv^
#
DUT_SCRIPT=$(basename "$0") # the name of this script
DUT_SCRIPT_CHECKSUM=$(md5sum $SCRIPT|awk '{print $1}') # This will generate an md5
source ~/.bashrc
DUT_CURRENT_LEVEL=$2 # current version from /etc/demon/version

log() { # pass to me the phrase to be logged only as a string
  printf "[log]: $1 \n"
}
updateVersion() { # pass to me the version to log the update
  echo $1 > /etc/demon/version
}
export -f log
export -f updateVersion

if [[ "$1" != "$DUT_SCRIPT_CHECKSUM" ]] # ensure this file is not called alone, ity must be called with it's own checksum
  then
    log "Got SCRIPT_CHECKSUM: $DUT_SCRIPT_CHECKSUM"
    printf "\n[ERROR]: This script should not be called directly.\n\tPlease use the \"demon-updater.sh\" command\n\n"
    exit 1337
else
  printf "[i] Initializing update tool ...  \n"
  # 1. get current version
  # 2. get updates
  # 3. run them
fi

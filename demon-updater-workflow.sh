#!/usr/bin/env bash
# This is the workflow of the updater It will call scripts based on the version of Demon Linux
# 2019 - WeakNet Labs - Douglas Berdeaux, DemonLinux.com ^vv^
#
source ~/.bashrc
DUT_SCRIPT=/usr/local/sbin/$(basename "$0") # the name of this script
DUT_LEVELS=/var/demon/updater/code/Demon-Update-Tool/update_scripts/
DUT_SCRIPT_CHECKSUM=$(md5sum $DUT_SCRIPT|awk '{print $1}') # This will generate an md5
DUT_CURRENT_LEVEL=$2 # current version from /etc/demon/version
DUT_HIGHEST_LEVEL=$(ls $DUT_LEVELS|sort -u|tail -n 1|awk -F. '{print $1}')

log() { # pass to me the phrase to be logged only as a string
  printf "\033[1;32m[\033[1;36m$(basename "$0")\033[1;33m log\033[1;32m]\033[0m: $1 \n"
}
updateVersion() { # pass to me the version to log the update
  echo $1 > /etc/demon/version
}
export -f log
export -f updateVersion

if [[ "$1" != "$DUT_SCRIPT_CHECKSUM" ]] # ensure this file is not called alone, ity must be called with it's own checksum
  then
    printf "\n[ERROR]: This script should not be called directly.\n\tPlease use the \"demon-updater.sh\" command\n\n"
    exit 1337
else
  log "Initializing update tool"
  log "Current version: $DUT_CURRENT_LEVEL"
  log "Highest level available: $DUT_HIGHEST_LEVEL"
  DUT_NEXT_LEVEL=$((DUT_CURRENT_LEVEL+=1))
  while [ $DUT_NEXT_LEVEL -le $DUT_HIGHEST_LEVEL ]
    do # run the script:
      log "Running update level: $DUT_NEXT_LEVEL"
      ${DUT_LEVELS}/${DUT_NEXT_LEVEL}.sh
      updateVersion $DUT_NEXT_LEVEL # record that we (at least tried) applied the update ...
      DUT_NEXT_LEVEL=$((DUT_NEXT_LEVEL+=1)) # postfix and run again ...
  done
fi
log "System now at version $DUT_NEXT_LEVEL. All updates are complete.\n"

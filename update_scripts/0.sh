#!/usr/bin/env bash
# Structure the script accordingly.
# UPDATE FILE
# SHOULD NOT RUN ALONE
source ~/.bashrc
DUT_GRN="\033[1;32m"
DUT_RST="\033[0m"
DUT_CYN="\033[1;36m"
DUT_YLW="\033[1;33m"
DUT_RED="\033[1;31m"
if [[ "$1" != "$DUT_SCRIPT_CHECKSUM" ]] # ensure this file is not called alone, ity must be called with it's own checksum
  then
    printf "\n[ERROR]: This script should not be called directly.\n\tPlease use the \"demon-updater.sh\" command\n\n"
    exit 1337
fi
log() {
  printf "${DUT_GRN}[${DUT_CYN}$(basename "$0")${DUT_YLW} log${DUT_GRN}]${DUT_RST}: $1 \n"
}
export -f log
log "Hello, I have initialized"
### Place all custom update code below this line.

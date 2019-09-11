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
DUT_SCRIPT=/var/demon/updater/code/Demon-Update-Tool/update_scripts/$(basename "$0")
DUT_SCRIPT_CHECKSUM=$(md5sum $DUT_SCRIPT|awk '{print $1}')

if [[ "$1" != "$DUT_SCRIPT_CHECKSUM" ]] # ensure this file is not called alone, ity must be called with it's own checksum
  then
    printf "\n${DUT_RED}[$(basename "$0") ERROR]: This script should not be called directly.\n\tPlease use the \"demon-updater.sh\" command.${DUT_RST}\n\n" 1>&2
    exit 57
fi
log() {
  printf "${DUT_GRN}[${DUT_CYN}$(basename "$0")${DUT_YLW} log${DUT_GRN}]${DUT_RST}: $1 \n"
}
export -f log
log "Hello. I have initialized"
### Place all custom update code below this line.
# 1. fix the font in LightDM:
log "Fixing the font issue with LightDM"
find /usr/share/fonts -iname '*.ttf' -type f -exec sudo chmod -v 644 {} \; 2>&1>/dev/null
find /usr/share/fonts -iname '*.otf' -type f -exec sudo chmod -v 644 {} \; 2>&1>/dev/null
sudo fc-cache -r -v 2>&1>/dev/null
# 2. ...

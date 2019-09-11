#!/usr/bin/env bash
# Demon Linux Updater Tool
#  This is the updater tool which will update its repo, check local version of patch level, run updates
#  This tool is self-maintained using GitHUB repository versioning.
#  2019 - WeakNet Labs, Douglas Berdeaux, DemonLinux.com
#

DUT_CODE_DIR=/var/demon/updater/code
DUT_REPO_DIR=$DUT_CODE_DIR/Demon-Update-Tool
DUT_GIT_REPO_URL=https://github.com/weaknetlabs/Demon-Update-Tool
DUT_CURRENT_LEVEL=$(cat /etc/demon/version||echo -1)

printf "\033[1;31m\nDemon Linux Update Tool\n2019 WeakNet Labs, Douglas Berdeaux\n\n\033[0m"
source ~/.bashrc
log() {
  printf "\033[1;32m[\033[1;33m$(basename "$0") log\033[1;32m]\033[0m: $1 \n"
}
export -f log

log "Current version $DUT_CURRENT_LEVEL"
### Check if Demon Linux directory structure exists:
if [[ ! -d "/etc/demon/" ]]
  then
    log "Creating /etc/demon local directory structure"
    mkdir -p /etc/demon
    echo 0 > /etc/demon/version # init as version 0
fi
if [[ ! -d "$DUT_CODE_DIR" ]]
  then
    mkdir -p $DUT_CODE_DIR
    cd $DUT_CODE_DIR
    git clone $DUT_GIT_REPO_URL
else
  cd $DUT_REPO_DIR && git pull
fi
### Update all scripts
cp $DUT_REPO_DIR/*.sh /usr/local/sbin # clobber the old files if necessary
chmod +x /usr/local/sbin/demon-updater-workflow.sh
chmod +x /usr/local/sbin/demon-updater.sh
log "Tool up to date, proceed with updates"

### Calling updater-workflow script
DUT_WORKFLOW_SCRIPT=/usr/local/sbin/demon-updater-workflow.sh
DUT_WORKFLOW_SCRIPT_CHECKSUM=$(md5sum $DUT_WORKFLOW_SCRIPT|awk '{print $1}')
log "Using CHECKSUM: $DUT_WORKFLOW_SCRIPT_CHECKSUM"
log "Calling WORKFLOW_SCRIPT: $DUT_WORKFLOW_SCRIPT"
$DUT_WORKFLOW_SCRIPT $DUT_WORKFLOW_SCRIPT_CHECKSUM $DUT_CURRENT_LEVEL

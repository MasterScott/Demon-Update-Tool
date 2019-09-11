#!/usr/bin/env bash
# Demon Linux Updater Tool
#  This is the updater tool which will update its repo, check local version of patch level, run updates
#  This tool is self-maintained using GitHUB repository versioning.
#  2019 - WeakNet Labs, Douglas Berdeaux, DemonLinux.com
#
WORKFLOW_SCRIPT=/usr/local/sbin/demon-updater-workflow.sh
WORKFLOW_SCRIPT_CHECKSUM=$(md5sum $WORKFLOW_SCRIPT|awk '{print $1}')
CODE_DIR=/var/demon/updater/code
REPO_DIR=$CODE_DIR/Demon-Update-Tool
GIT_REPO_URL=https://github.com/weaknetlabs/Demon-Update-Tool
CURRENT_LEVEL=$(cat /etc/demon/version||echo 0)

printf "\033[1;31m\nDemon Linux Update Tool\n2019 WeakNet Labs, Douglas Berdeaux\n\n\033[0m"
source ~/.bashrc
log() {
  printf "\033[1;32m[\033[1;33mlog\033[1;32m]\033[0m: $1 \n"
}
export -f log

log "Current version $CURRENT_LEVEL"
### Check if Demon Linux directory structure exists:
if [[ ! -d "/etc/demon/" ]]
  then
    log "Creating /etc/demon local directory structure"
    mkdir -p /etc/demon
    echo 0 > /etc/demon/version # init as version 0
fi
if [[ ! -d "$CODE_DIR" ]]
  then
    log "Creating $CODE_DIR local directory structure"
    mkdir -p $CODE_DIR
    log "Cloning remote repository"
    cd $CODE_DIR
    git clone $GIT_REPO_URL
else
  cd $REPO_DIR && git pull
fi

log "Copying binary to \$PATH"
cp $REPO_DIR/*.sh /usr/local/sbin # clobber the old files if necessary
chmod +x /usr/local/sbin/demon-updater-workflow.sh
chmod +x /usr/local/sbin/demon-updater.sh
log "Tool up to date, proceed with updates"

### Calling updater-workflow script
log "Using CHECKSUM: $WORKFLOW_SCRIPT_CHECKSUM"
log "Calling WORKFLOW_SCRIPT: $WORKFLOW_SCRIPT"
$WORKFLOW_SCRIPT $WORKFLOW_SCRIPT_CHECKSUM

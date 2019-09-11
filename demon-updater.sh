#!/usr/bin/env bash
# Demon Linux Updater Tool
#  This is the updater tool which will update its repo, check local version of patch level, run updates
#  This tool is self-maintained using GitHUB repository versioning.
#  2019 - WeakNet Labs, Douglas Berdeaux, DemonLinux.com
#
#WORKFLOW_SCRIPT=usr/local/sbin/demon-updater-workflow.sh
WORKFLOW_SCRIPT=demon-updater-workflow.sh
WORKFLOW_SCRIPT_CHECKSUM=$(md5sum $WORKFLOW_SCRIPT|awk '{print $1}')
CODE_DIR=/var/demon/updater/code
GIT_REPO_URL=https://github.com/weaknetlabs/Demon-Update-Tool

source ~/.bashrc
log() {
  printf "[log]: $1 \n"
}
export -f log

### Check if Demon Linux directory structure exists:
if [[ ! -d "/etc/demon/" ]]
  then
    log "Creating /etc/demon local directory structure"
    mkdir -p /etc/demon
    echo 0 > /etc/demon/version # init as version 0
fi
if [[ -d "$CODE_DIR" ]]
  then
    log "Creating $CODE_DIR local directory structure"
    mkdir -p $CODE_DIR
    log "Cloning remote repository"
    cd $CODE_DIR
    git clone $GIT_REPO_URL
else
  cd $CODE_DIR && git pull
fi
log "Copying binary to \$PATH"
cp $CODE_DIR/*.sh /usr/local/sbin
log "Tool up to date, proceed with updates"

### Calling updater-workflow script
log "Using CHECKSUM: $WORKFLOW_SCRIPT_CHECKSUM"
log "Calling WORKFLOW_SCRIPT: $WORKFLOW_SCRIPT"
./$WORKFLOW_SCRIPT $WORKFLOW_SCRIPT_CHECKSUM

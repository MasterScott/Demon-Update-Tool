#!/usr/bin/env bash
source ~/.bashrc
log() {
  printf "\033[1;32m[\033[1;33m$(basename $0) log\033[1;32m]\033[0m: $1 \n"
}
export -f log

log " <-- This update script has initialized"

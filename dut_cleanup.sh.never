#!/usr/bin/env bash
# DO NOT RUN THIS SCRIPT
# FOR DEBUGGING PURPOSES ONLY
source ~/.bashrc
printf "[LOG] basename 0: $(basename "$0")\n"
CHECKSUM=$(md5sum $(basename "$0")|awk '{print $1}')
printf "[LOG] CHECKSUM: $CHECKSUM\n"
if [[ "$1" != "$CHECKSUM" ]]
  then
    printf "[ERROR]: DO NOT RUN THIS SCRIPT.\n"
    exit 1337
else
    rm -rf /etc/demon
    rm -rf /var/demon/updater
    rm -rf /usr/local/sbin/demon-update*
fi
printf "[!] Cleanup completed.\n[!] Exiting.\n\n"
exit 0

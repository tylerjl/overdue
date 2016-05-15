#!/usr/bin/env bash

# read in file list from pacman hook
# must add / since files passed by the hook don't have it
files=""
while read -r f; do
    files="${files} /${f}"
done
[[ -z "$files" ]] && exit 0

# get the PID's of processes using the files
# echo is needed to remove leading whitespace
# have to check if we actually got any PID's; otherwise ps returns
# user1000.service, etc.
pids=$(echo $(fuser $files 2> /dev/null))
[[ -z "$pids" ]] && exit 0

# get and sort the systemd unit names, removing duplicates
services="$(ps -o unit= $pids)"
services=$(echo "$services" | sort | uniq)
[[ -z "$services" ]] && exit 0

echo "The following systemd services have stale file handles open to"
echo "libraries that have been upgraded:"
for i in $services; do
    echo -e "  $i"
done

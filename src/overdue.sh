#!/usr/bin/env bash

files=""
while read -r f; do
    files="${files} /${f}"
done

pids=$(echo $(fuser $files 2> /dev/null))
services="$(ps -o unit= $pids)"
services=$(echo "$services" | sort | uniq)

if [[ -n "$services" ]]; then
    echo "The following systemd services have stale file handles open to"
    echo "libraries that have been upgraded:"
    for i in $services; do
        echo -e "  $i"
    done
fi

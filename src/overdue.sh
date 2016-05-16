#!/usr/bin/env bash

if [[ "$EUID" != "0" ]] ; then
    echo 'You must be root to run this program.'
    exit 1
fi

pids="$(lsof -d DEL | awk 'NR>1 {printf $2" "}')"
[[ -z "$pids" ]] && exit 0

services="$(ps -o unit= $pids | sort -u)"
[[ -z "$services" ]] && exit 0

echo "The following daemons/units have stale file handles open to
libraries that have been upgraded. Consider restarting them
if they should reference updated shared libraries.

$services"

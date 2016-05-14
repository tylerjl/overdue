#!/usr/bin/env bash

declare services=""
while read -r f; do
    i="$(ps -o unit= $(fuser $f 2> /dev/null))"
    for service in $i; do
        if [[ -n "$service" ]]; then
            services="${services}\n${service}"
        fi
    done
done
services=$(sort <(echo -e $services) | uniq)

if [[ -n "$services" ]]; then
    echo "The following systemd services have stale file handles open to"
    echo "libraries that have been upgraded:"
    for i in $services; do
        echo -e "  $i"
    done
fi

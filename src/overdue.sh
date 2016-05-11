#!/usr/bin/env sh

if [ "$EUID" != "0" ] ; then
    echo 'You must be root to run this program.'
    exit 1
fi

services="$(lsof -d DEL -F pn0 |\
    awk -f /usr/share/overdue/overdue.awk |\
    xargs -L1 systemctl status --no-pager 2>/dev/null |\
    grep -E '[.]\w+ - ' |\
    sort | uniq | sort)"

if [ ! -z "$services" ] ; then
    echo "The following daemons/units have stale file handles open to
libraries that have been upgraded. Consider restarting them
if they should reference updated shared libraries.

$services"
fi

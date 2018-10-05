#!/usr/bin/env bats

load stubs

@test 'lsof stub' {
    run lsof
    [ "$status" -eq 0 ]
}

@test 'overdue in PATH' {
    run overdue.sh
    [ "$status" -eq 0 ]
}

@test 'overdue output' {
    expected='The following daemons/units have stale file handles open to
libraries that have been upgraded. Consider restarting them
if they should reference updated shared libraries.
    ● dbus.service
    ● dhcpcd@enp2s0.service
    ● dhcpcd.service
    ● getty@tty1.service
    ● init.scope
    ● lvm2-lvmetad.service
    ● NetworkManager.service
    ● polkit.service
    ● postgresql.service
    ● user@1000.service
    ● zed.service
'
    run bash overdue.sh
    [ "x$output" = "x${expected}" ]
}

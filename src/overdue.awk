BEGIN {
    # Use the -F 0 flag in lsof to delimit fields with NUL
    FS = "\0"
}

# lsof will print entries for -F in the format:
#
# p1234
# fDELn/bar/baz
# fDELn/bar/foo
#
# And so on for each process. Thus in the following script we set the pid
# after seeing a new p\d+ line.

{
    if ($1 ~ /^p/) {
        # If the line indicates the following records are descriptors for
        # a process, store the pid as not needing a restart (zero.)
        pid = substr($1, 2)
        pids[pid] = 0
    } else if ($2 ~ /lib\//) {
        # Otherwise, if the deleted descriptor is a library, mark as a stale
        # handle.
        pids[pid] = 1
    }
}

END {
    # Print each process with stale library handles.
    for (pid in pids)
        if (pids[pid]) {
            print pid
        }
}

# overdue

Overdue is a [pacman](https://wiki.archlinux.org/index.php/pacman) post-transaction hook that looks for running daemons that reference deleted shared library file handles and notifies you about them.
It's a simple shell script that makes no changes to your system, and lists all relevant units for easy reference.

## Why?

Many people don't realize that when a high-profile shared library gets updated with important changes or fixes (such as OpenSSL), executables that loaded that shared library at start time don't use that updated code until they get restarted.
This is usually fairly benign, but when a shared library like OpenSSL gets a security update, it's pretty important to restart dependent daemons in order to reference shared libraries that have fixes applied.
For example, if you were to update the `openssl` package to fix a vulnerability like Heartbleed, your webserver would *not* be fixed until nginx/Apache were restarted.

## Use

Installing this package via the [AUR](https://aur.archlinux.org/) is sufficient.
The informational hook will run whenever files in `/usr/lib` or `/usr/lib64` are updated.

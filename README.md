# overdue

Overdue is a [pacman](https://wiki.archlinux.org/index.php/pacman) post-transaction hook that looks for running daemons that reference deleted shared library file handles and notifies you about them.
It's a simple shell script that makes no changes to your system, and lists all relevant units for easy reference.

## Example

```
vagrant@archlinux:~$ sudo pacman -S libassuan
resolving dependencies...
looking for conflicting packages...

Packages (1) libassuan-2.4.2-2

Total Download Size:   0.08 MiB
Total Installed Size:  0.18 MiB
Net Upgrade Size:      0.03 MiB

:: Proceed with installation? [Y/n] y
:: Retrieving packages...
 libassuan-2.4.2-2-x86_64  84.4 KiB  63.0K/s 00:01 [##########################################] 100%
 (1/1) checking keys in keyring                    [##########################################] 100%
 (1/1) checking package integrity                  [##########################################] 100%
 (1/1) loading package files                       [##########################################] 100%
 (1/1) checking for file conflicts                 [##########################################] 100%
 (1/1) checking available disk space               [##########################################] 100%
 :: Processing package changes...
 (1/1) upgrading libassuan                         [##########################################] 100%
 :: Running post-transaction hooks...
 (1/1) Checking for stale library file handles...
 The following daemons/units have stale file handles open to
 libraries that have been upgraded. Consider restarting them
 if they should reference updated shared libraries.
 ● sshd.service
```

## Why?

Many people don't realize that when a high-profile shared library gets updated with important changes or fixes (such as OpenSSL), executables that loaded that shared library at start time don't use that updated code until they get restarted.
This is usually fairly benign, but when a shared library like OpenSSL gets a security update, it's pretty important to restart dependent daemons in order to reference shared libraries that have fixes applied.
For example, if you were to update the `openssl` package to fix a vulnerability like Heartbleed, your webserver would *not* be fixed until nginx/Apache were restarted.

## Use

Installing this package via the [AUR](https://aur.archlinux.org/) is sufficient.
The informational hook will run whenever files in `/usr/lib` or `/usr/lib64` are updated.

.DEFAULT = install

PREFIX ?= /

.PHONY: install
install:
	install -D -m0644 src/overdue.awk $(PREFIX)/usr/share/overdue/overdue.awk
	install -D -m0644 src/overdue-libraries-upgrade.hook \
		$(PREFIX)/usr/share/libalpm/hooks/overdue-libraries-upgrade.hook
	install -D -m0755 src/overdue.sh  $(PREFIX)/usr/bin/overdue

.PHONY: uninstall
uninstall:
	rm -rf $(PREFIX)/usr/share/overdue
	rm     $(PREFIX)/usr/share/libalpm/hooks/overdue-libraries-upgrade.hook
	rm     $(PREFIX)/usr/bin/overdue

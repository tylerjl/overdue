.DEFAULT = install

PREFIX ?= /

.PHONY: install
install:
	install -D -m0644 src/overdue-libraries-upgrade.hook \
		$(PREFIX)/usr/share/libalpm/hooks/overdue-libraries-upgrade.hook
	install -D -m0755 src/overdue.sh  $(PREFIX)/usr/share/libalpm/scripts/overdue

.PHONY: uninstall
uninstall:
	rm     $(PREFIX)/usr/share/libalpm/hooks/overdue-libraries-upgrade.hook
	rm     $(PREFIX)/usr/share/libalpm/scripts/overdue

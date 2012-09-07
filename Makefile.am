SUBDIRS = \
	data \
	po \
	src

EXTRA_DIST = \
	autogen.sh \
	config.rpath \
	ltmain.sh \
	BUGS \
	HACKING \
	AUTHORS \
	NEWS \
	TODO

pkgdatadir = \
	$(datarootdir)/$(PACKAGE_NAME)

pkgdata_DATA = \
	HACKING \
	AUTHORS \
	BUGS \
	ChangeLog \
	COPYING \
	INSTALL \
	NEWS \
	README

NHOPKG_DIRS = \
	$(DESTDIR)$(localstatedir)/$(PACKAGE_NAME) \
	$(DESTDIR)$(localstatedir)/$(PACKAGE_NAME)/cache \
	$(DESTDIR)$(localstatedir)/$(PACKAGE_NAME)/files \
	$(DESTDIR)$(localstatedir)/$(PACKAGE_NAME)/logs \
	$(DESTDIR)$(localstatedir)/$(PACKAGE_NAME)/packages \
	$(DESTDIR)$(localstatedir)/$(PACKAGE_NAME)/repo \
	$(DESTDIR)$(localstatedir)/$(PACKAGE_NAME)/repo/files \
	$(DESTDIR)$(localstatedir)/$(PACKAGE_NAME)/repo/packages

install-data-local:
	list='$(NHOPKG_DIRS)'; \
	for nhopkg_dirs in $$list; do \
		$(mkinstalldirs) $$nhopkg_dirs; \
	done

ACLOCAL_AMFLAGS = -I m4

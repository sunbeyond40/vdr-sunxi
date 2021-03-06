export BASEDIR = $(shell pwd)

SRCDIR=VDR

include $(SRCDIR)/Make.config

VDRVERSION = $(shell sed -ne '/define VDRVERSION/s/^.*"\(.*\)".*$$/\1/p' $(SRCDIR)/config.h)
DATE = $(shell date +%Y%m%d"_"%H%M)
TARBALL = vdr-$(VDRVERSION)-armhf$(DATE).tar.bz2

all clean clean-plugins plugins install:
	(export PKG_CONFIG_PATH=/usr/lib/arm-linux-gnueabihf/pkgconfig; cd $(SRCDIR); $(MAKE) $@)

archive: $(DESTDIR)/usr/local/bin/vdr
	(cd $(DESTDIR) &&\
	$(STRIP) --strip-unneeded usr/local/bin/vdr &&\
	$(STRIP) --strip-unneeded `find . -name lib*.so.* -print` &&\
	tar -cjvf ../$(TARBALL) . \
	)

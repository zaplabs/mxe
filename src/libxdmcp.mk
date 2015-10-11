# This file is part of MXE.
# See index.html for further information.

PKG             := libxdmcp
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.1.2
$(PKG)_CHECKSUM := 81fe09867918fff258296e1e1e159f0dc639cb30d201c53519f25ab73af4e4e2
$(PKG)_SUBDIR   := libXdmcp-$($(PKG)_VERSION)
$(PKG)_FILE     := $($(PKG)_SUBDIR).tar.bz2
$(PKG)_URL      := http://xorg.freedesktop.org/releases/individual/lib/$($(PKG)_FILE)
$(PKG)_DEPS     := xorg-util-macros

define $(PKG)_UPDATE
    $(WGET) -q -O- 'http://cgit.freedesktop.org/xorg/lib/libXdmcp/refs/tags' | \
    $(SED) -n "s,.*<a href='[^']*/tag/?id=libXdmcp-\\([0-9.]*\\)'.*,\\1,p" | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(1)' && autoreconf -fi -I'$(PREFIX)/$(TARGET)/share/aclocal'
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS)
    $(MAKE) -C '$(1)' -j '$(JOBS)' install pkgconfigdir='$$(libdir)/pkgconfig'
endef

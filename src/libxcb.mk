# This file is part of MXE.
# See index.html for further information.

PKG             := libxcb
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.11.1
$(PKG)_CHECKSUM := b720fd6c7d200e5371affdb3f049cc8f88cff9aed942ff1b824d95eedbf69d30
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $($(PKG)_SUBDIR).tar.bz2
$(PKG)_URL      := http://xcb.freedesktop.org/dist/$($(PKG)_FILE)
$(PKG)_DEPS     := xcb-proto xcb-pthread-stubs xorg-libxau libxdmcp

define $(PKG)_UPDATE
    $(WGET) -q -O- 'http://cgit.freedesktop.org/xcb/libxcb/refs/tags' | \
    $(SED) -n "s,.*<a href='[^']*/tag/?id=libxcb-\\([0-9.]*\\)'.*,\\1,p" | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(1)' && autoreconf -fi -I'$(PREFIX)/$(TARGET)/share/aclocal'
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS)
    $(MAKE) -C '$(1)' -j '$(JOBS)' install pkgconfigdir='$$(libdir)/pkgconfig'
endef

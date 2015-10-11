# This file is part of MXE.
# See index.html for further information.

PKG             := xorg-libxpm
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3.5.11
$(PKG)_CHECKSUM := c5bdafa51d1ae30086fac01ab83be8d47fe117b238d3437f8e965434090e041c
$(PKG)_SUBDIR   := libXpm-$($(PKG)_VERSION)
$(PKG)_FILE     := $($(PKG)_SUBDIR).tar.bz2
$(PKG)_URL      := http://xorg.freedesktop.org/releases/individual/lib/$($(PKG)_FILE)
$(PKG)_DEPS     := xorg-xproto xorg-xextproto xorg-libx11 xorg-libxt

define $(PKG)_UPDATE
    $(WGET) -q -O- 'http://cgit.freedesktop.org/xorg/lib/libXpm/refs/tags' | \
    $(SED) -n "s,.*<a href='[^']*/tag/?id=libXpm-\\([0-9.]*\\)'.*,\\1,p" | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(1)' && autoreconf -fi -I'$(PREFIX)/$(TARGET)/share/aclocal'
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS) --enable-ipv6
    $(MAKE) -C '$(1)' -j '$(JOBS)' install pkgconfigdir='$$(libdir)/pkgconfig'
endef

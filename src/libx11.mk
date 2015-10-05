# This file is part of MXE.
# See index.html for further information.

PKG             := libx11
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.6.3
$(PKG)_CHECKSUM := cf31a7c39f2f52e8ebd0db95640384e63451f9b014eed2bb7f5de03e8adc8111
$(PKG)_SUBDIR   := libX11-$($(PKG)_VERSION)
$(PKG)_FILE     := $($(PKG)_SUBDIR).tar.bz2
$(PKG)_URL      := http://xorg.freedesktop.org/releases/individual/lib/$($(PKG)_FILE)
$(PKG)_DEPS     := xproto xextproto xtrans kbproto inputproto libxcb libxau

define $(PKG)_UPDATE
    $(WGET) -q -O- 'http://cgit.freedesktop.org/xorg/lib/libX11/refs/tags' | \
    $(SED) -n "s,.*<a href='[^']*/tag/?id=libX11-\\([0-9.]*\\)'.*,\\1,p" | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(1)' && autoreconf -fi -I'$(PREFIX)/$(TARGET)/share/aclocal'
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS) --disable-ipv6 --enable-malloc0returnsnull --enable-xlocaledir
    $(MAKE) -C '$(1)' -j '$(JOBS)' pkgconfigdir='$$(libdir)/pkgconfig'
    $(MAKE) -C '$(1)' install pkgconfigdir='$$(libdir)/pkgconfig'
endef

# This file is part of MXE.
# See index.html for further information.

PKG             := xorg-libsm
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.2.2
$(PKG)_CHECKSUM := 0baca8c9f5d934450a70896c4ad38d06475521255ca63b717a6510fdb6e287bd
$(PKG)_SUBDIR   := libSM-$($(PKG)_VERSION)
$(PKG)_FILE     := $($(PKG)_SUBDIR).tar.bz2
$(PKG)_URL      := http://xorg.freedesktop.org/releases/individual/lib/$($(PKG)_FILE)
$(PKG)_DEPS     := xorg-util-macros xorg-xproto xorg-xtrans xorg-libice libuuid-mingw

define $(PKG)_UPDATE
    $(WGET) -q -O- 'http://cgit.freedesktop.org/xorg/lib/libSM/refs/tags' | \
    $(SED) -n "s,.*<a href='[^']*/tag/?id=libSM-\\([0-9.]*\\)'.*,\\1,p" | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(1)' && autoreconf -fi -I'$(PREFIX)/$(TARGET)/share/aclocal'
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS) --with-libuuid --enable-ipv6
    $(MAKE) -C '$(1)' -j '$(JOBS)' install pkgconfigdir='$$(libdir)/pkgconfig'
endef

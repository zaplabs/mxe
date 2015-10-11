# This file is part of MXE.
# See index.html for further information.

PKG             := xorg-xproto
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 7.0.28
$(PKG)_CHECKSUM := 29e85568d1f68ceef8a2c081dad9bc0e5500a53cfffde24b564dc43d46ddf6ca
$(PKG)_SUBDIR   := $(patsubst xorg-%,%,$(PKG))-$($(PKG)_VERSION)
$(PKG)_FILE     := $(patsubst xorg-%,%,$(PKG))-$($(PKG)_VERSION).tar.bz2
$(PKG)_URL      := http://xorg.freedesktop.org/releases/individual/proto/$($(PKG)_FILE)
$(PKG)_DEPS     := xorg-util-macros

define $(PKG)_UPDATE
    $(WGET) -q -O- 'http://cgit.freedesktop.org/xorg/proto/xproto/refs/tags' | \
    $(SED) -n "s,.*<a href='[^']*/tag/?id=xproto-\\([0-9.]*\\)'.*,\\1,p" | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(1)' && autoreconf -fi -I'$(PREFIX)/$(TARGET)/share/aclocal'
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS)
    $(MAKE) -C '$(1)' -j '$(JOBS)' install pkgconfigdir='$$(libdir)/pkgconfig'
endef

# This file is part of MXE.
# See index.html for further information.

PKG             := libxmu
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.1.2
$(PKG)_CHECKSUM := 756edc7c383254eef8b4e1b733c3bf1dc061b523c9f9833ac7058378b8349d0b
$(PKG)_SUBDIR   := libXmu-$($(PKG)_VERSION)
$(PKG)_FILE     := $($(PKG)_SUBDIR).tar.bz2
$(PKG)_URL      := http://xorg.freedesktop.org/releases/individual/lib/$($(PKG)_FILE)
$(PKG)_DEPS     := xorg-macros libx11 libxext libxt

define $(PKG)_UPDATE
    $(WGET) -q -O- 'http://cgit.freedesktop.org/xorg/lib/libXmu/refs/tags' | \
    $(SED) -n "s,.*<a href='[^']*/tag/?id=libXmu-\\([0-9.]*\\)'.*,\\1,p" | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(1)' && autoreconf -fi -I'$(PREFIX)/$(TARGET)/share/aclocal'
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS) --disable-ipv6
    $(MAKE) -C '$(1)' -j '$(JOBS)' install pkgconfigdir='$$(libdir)/pkgconfig'
endef

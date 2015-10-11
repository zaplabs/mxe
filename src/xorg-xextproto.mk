# This file is part of MXE.
# See index.html for further information.

PKG             := xorg-xextproto
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 7.3.0
$(PKG)_CHECKSUM := f3f4b23ac8db9c3a9e0d8edb591713f3d70ef9c3b175970dd8823dfc92aa5bb0
$(PKG)_SUBDIR   := $(patsubst xorg-%,%,$(PKG))-$($(PKG)_VERSION)
$(PKG)_FILE     := $($(PKG)_SUBDIR).tar.bz2
$(PKG)_URL      := http://xorg.freedesktop.org/releases/individual/proto/$($(PKG)_FILE)
$(PKG)_DEPS     := xorg-util-macros

define $(PKG)_UPDATE
    $(WGET) -q -O- 'http://cgit.freedesktop.org/xorg/proto/xextproto/refs/tags' | \
    $(SED) -n "s,.*<a href='[^']*/tag/?id=xextproto-\\([0-9.]*\\)'.*,\\1,p" | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(1)' && autoreconf -fi -I'$(PREFIX)/$(TARGET)/share/aclocal'
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS)
    $(MAKE) -C '$(1)' -j '$(JOBS)' install pkgconfigdir='$$(libdir)/pkgconfig'
endef

# This file is part of MXE.
# See index.html for further information.

PKG             := xcb-proto
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.11
#$(PKG)_REV      := 8d0c1007a7dd776f0163533464070731b6ebfc9b
$(PKG)_CHECKSUM := b4aceee6502a0ce45fc39b33c541a2df4715d00b72e660ebe8c5bb444771e32e
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
#$(PKG)_SUBDIR   := $(patsubst xcb-%,%,$(PKG))-$($(PKG)_VERSION)
$(PKG)_FILE     := $($(PKG)_SUBDIR).tar.bz2
$(PKG)_URL      := http://xcb.freedesktop.org/dist/$($(PKG)_FILE)
#$(PKG)_URL      := http://cgit.freedesktop.org/xcb/proto/snapshot/$($(PKG)_FILE)
$(PKG)_DEPS     := xorg-util-macros

define $(PKG)_UPDATE
    $(WGET) -q -O- 'http://cgit.freedesktop.org/xcb/proto/refs/tags' | \
    $(SED) -n "s,.*<a href='[^']*/tag/?id=proto-\\([0-9.]*\\)'.*,\\1,p" | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(1)' && autoreconf -fi -I'$(PREFIX)/$(TARGET)/share/aclocal'
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS)
    $(MAKE) -C '$(1)' -j '$(JOBS)' install pkgconfigdir='$$(libdir)/pkgconfig'
endef

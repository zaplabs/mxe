# This file is part of MXE.
# See index.html for further information.

PKG             := xcb-pthread-stubs
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.3
$(PKG)_CHECKSUM := 35b6d54e3cc6f3ba28061da81af64b9a92b7b757319098172488a660e3d87299
$(PKG)_SUBDIR   := lib$(patsubst xcb-%,%,$(PKG))-$($(PKG)_VERSION)
$(PKG)_FILE     := $($(PKG)_SUBDIR).tar.bz2
$(PKG)_URL      := http://xcb.freedesktop.org/dist/$($(PKG)_FILE)
$(PKG)_DEPS     := xorg-util-macros pthreads

define $(PKG)_UPDATE
    $(WGET) -q -O- 'http://cgit.freedesktop.org/xcb/pthread-stubs/refs/tags' | \
    $(SED) -n "s,.*<a href='[^']*/tag/?id=pthread-stubs-\\([0-9.]*\\)'.*,\\1,p" | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(1)' && autoreconf -fi -I'$(PREFIX)/$(TARGET)/share/aclocal'
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS) LIBS=-lpthread
    sed -i 's/^Libs: /Libs: -lpthread/' '$(1)/pthread-stubs.pc'
    $(MAKE) -C '$(1)' -j '$(JOBS)' install pkgconfigdir='$$(libdir)/pkgconfig'
endef

# This file is part of MXE.
# See index.html for further information.

PKG             := libxt
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.1.5
$(PKG)_CHECKSUM := 46eeb6be780211fdd98c5109286618f6707712235fdd19df4ce1e6954f349f1a
$(PKG)_SUBDIR   := libXt-$($(PKG)_VERSION)
$(PKG)_FILE     := $($(PKG)_SUBDIR).tar.bz2
$(PKG)_URL      := http://xorg.freedesktop.org/releases/individual/lib/$($(PKG)_FILE)
$(PKG)_DEPS     := glib libsm libice libx11 xproto kbproto

define $(PKG)_UPDATE
    $(WGET) -q -O- 'http://cgit.freedesktop.org/xorg/lib/libXt/refs/tags' | \
    $(SED) -n "s,.*<a href='[^']*/tag/?id=libXt-\\([0-9.]*\\)'.*,\\1,p" | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(1)' && autoreconf -fi -I'$(PREFIX)/$(TARGET)/share/aclocal'
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS) --enable-malloc0returnsnull
    $(MAKE) -C '$(1)' -j '$(JOBS)' install pkgconfigdir='$$(libdir)/pkgconfig'
endef

$(PKG)_BUILD_x86_64-w64-mingw32 =

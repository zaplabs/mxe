# This file is part of MXE.
# See index.html for further information.

PKG             := xorg-libxaw
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.0.13
$(PKG)_CHECKSUM := b518d4d332231f313371fdefac59e3776f4f0823bcb23cf7c7305bfb57b16e35
$(PKG)_SUBDIR   := libXaw-$($(PKG)_VERSION)
$(PKG)_FILE     := $($(PKG)_SUBDIR).tar.bz2
$(PKG)_URL      := http://xorg.freedesktop.org/releases/individual/lib/$($(PKG)_FILE)
$(PKG)_DEPS     := xorg-xproto xorg-xextproto xorg-libx11 xorg-libxext xorg-libxt xorg-libxmu xorg-libxpm

define $(PKG)_UPDATE
    $(WGET) -q -O- 'http://cgit.freedesktop.org/xorg/lib/libXaw/refs/tags' | \
    $(SED) -n "s,.*<a href='[^']*/tag/?id=libXaw-\\([0-9.]*\\)'.*,\\1,p" | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(1)' && autoreconf -fi -I'$(PREFIX)/$(TARGET)/share/aclocal'
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS) --enable-malloc0returnsnull
    $(MAKE) -C '$(1)' -j '$(JOBS)' install pkgconfigdir='$$(libdir)/pkgconfig'
endef

$(PKG)_BUILD_x86_64-w64-mingw32 =

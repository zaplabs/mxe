# This file is part of MXE.
# See index.html for further information.

# Note that IPv6 support is partly broken and therefore disabled.

PKG             := libuuid-mingw
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.0.1
$(PKG)_CHECKSUM := 666e0f49615b1cc5589e3172aa404de0a64ef31246cbdf71c93dd5be6ee31665
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://github.com/h0tw1r3/libuuid-mingw/archive/$($(PKG)_VERSION).tar.gz
$(PKG)_DEPS     := gcc

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://github.com/h0tw1r3/libuuid-mingw/releases' | \
    $(SED) -n 's,.*/archive/\([0-9][^>]*\)\.tar.*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(1)' && autoreconf -fi -I'$(PREFIX)/$(TARGET)/share/aclocal'
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS)
    $(MAKE) -C '$(1)' -j '$(JOBS)' install pkgconfigdir='$$(libdir)/pkgconfig'
endef

# This file is part of MXE.
# See index.html for further information.

PKG             := inputproto
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.3.1
$(PKG)_CHECKSUM := 5a47ee62053a6acef3a83f506312494be1461068d0b9269d818839703b95c1d1
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $($(PKG)_SUBDIR).tar.bz2
$(PKG)_URL      := http://xorg.freedesktop.org/releases/individual/proto/$($(PKG)_FILE)
$(PKG)_DEPS     :=

define $(PKG)_UPDATE
    $(WGET) -q -O- 'http://cgit.freedesktop.org/xorg/proto/inputproto/refs/tags' | \
    $(SED) -n "s,.*<a href='[^']*/tag/?id=xproto-\\([0-9.]*\\)'.*,\\1,p" | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS)
    $(MAKE) -C '$(1)' -j '$(JOBS)' install pkgconfigdir='$$(libdir)/pkgconfig'
endef

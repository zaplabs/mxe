# This file is part of MXE.
# See index.html for further information.

PKG             := xtrans
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.3.5
$(PKG)_CHECKSUM := adbd3b36932ce4c062cd10f57d78a156ba98d618bdb6f50664da327502bc8301
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $($(PKG)_SUBDIR).tar.bz2
$(PKG)_URL      := http://xorg.freedesktop.org/releases/individual/lib/$($(PKG)_FILE)
$(PKG)_DEPS     :=

define $(PKG)_UPDATE
    $(WGET) -q -O- 'http://cgit.freedesktop.org/xorg/lib/libxtrans/refs/tags' | \
    $(SED) -n "s,.*<a href='[^']*/tag/?id=libxtrans-\\([0-9.]*\\)'.*,\\1,p" | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS)
    $(MAKE) -C '$(1)' -j '$(JOBS)' install pkgconfigdir='$$(libdir)/pkgconfig'
endef

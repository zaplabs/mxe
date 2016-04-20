# This file is part of MXE.
# See index.html for further information.

PKG             := libmpeg2
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.5.1
$(PKG)_CHECKSUM := dee22e893cb5fc2b2b6ebd60b88478ab8556cb3b93f9a0d7ce8f3b61851871d4
$(PKG)_SUBDIR   := libmpeg2-$($(PKG)_VERSION)
$(PKG)_FILE     := libmpeg2-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := http://libmpeg2.sourceforge.net/files/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc sdl2

define $(PKG)_BUILD
    cd '$(1)' && autoreconf -fi
    cd '$(1)' && ./configure \
        $(MXE_CONFIGURE_OPTS)

    $(MAKE) -C '$(1)' -j '$(JOBS)' $(MXE_DISABLE_CRUFT) LDFLAGS='-no-undefined'
    $(MAKE) -C '$(1)' -j 1 install $(MXE_DISABLE_CRUFT)
endef

$(PKG)_BUILD_SHARED =

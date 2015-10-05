# This file is part of MXE.
# See index.html for further information.

PKG             := xcb-proto
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.11
$(PKG)_CHECKSUM := b4aceee6502a0ce45fc39b33c541a2df4715d00b72e660ebe8c5bb444771e32e
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.bz2
$(PKG)_URL      := http://xcb.freedesktop.org/dist/$($(PKG)_FILE)
$(PKG)_DEPS     := 

define $(PKG)_BUILD
    cd '$(1)' && ./configure $(MXE_CONFIGURE_OPTS)
    $(MAKE) -C '$(1)' -j '$(JOBS)' install pkgconfigdir='$$(libdir)/pkgconfig'
endef

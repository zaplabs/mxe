# This file is part of MXE.
# See index.html for further information.

PKG             := mingw-w64
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3deeda3a1db3dee8a8b6231be5b44f47d79ce1d7
$(PKG)_CHECKSUM := e0a17e92cc4f58f0d72cfbff381c6f0ad532adeb6a552e85d4f8b58857e309ab
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://github.com/mirror/mingw-w64/archive/$($(PKG)_VERSION).tar.gz
$(PKG)_DEPS     :=

$(PKG)_UPDATE    = $(call MXE_GET_GITHUB_SHA, mirror/mingw-w64, master)

#define $(PKG)_UPDATE
#    $(WGET) -q -O- 'http://sourceforge.net/projects/mingw-w64/files/mingw-w64/mingw-w64-release/' | \
#    $(SED) -n 's,.*mingw-w64-v\([0-9.]*\)\(-rc[0-9]*\)\{0\,1\}\.tar.*,\1\2,p' | \
#    $(SORT) -uV | \
#    tail -1
#endef

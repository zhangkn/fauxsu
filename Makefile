TARGET = native
#DEBUG = 1
GO_EASY_ON_ME = 1
include theos/makefiles/common.mk

LIBRARY_NAME = libfauxsu
libfauxsu_FILES = fauxsu.cc
libfauxsu_INSTALL_PATH = /usr/libexec/fauxsu

#TOOL_NAME = test
test_FILES = test.c

ADDITIONAL_CFLAGS = -Wno-format -Wno-sign-compare

include $(FW_MAKEDIR)/library.mk
#include $(FW_MAKEDIR)/tool.mk

after-all:: $(FW_OBJ_DIR)/fauxsu.sh

internal-stage::
	@mkdir -p $(FW_STAGING_DIR)/usr/bin
	@cp $(FW_OBJ_DIR)/fauxsu.sh $(FW_STAGING_DIR)/usr/bin/fauxsu
	@chmod +x $(FW_STAGING_DIR)/usr/bin/fauxsu

$(FW_OBJ_DIR)/fauxsu.sh: fauxsu.sh.in
	@sed -e 's|@@FAUXSU_INSTALL_PATH@@|$(libfauxsu_INSTALL_PATH)|g' $< > $@

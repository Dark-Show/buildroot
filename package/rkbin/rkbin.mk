################################################################################
#
# rkbin
#
################################################################################

RKBIN_VERSION = 991d0e441c74f93813e6a2b7e8d6ef8a136985ad
RKBIN_SOURCE = $(RKBIN_VERSION).tar.gz
RKBIN_SITE = $(call github,knaerzche,rkbin,$(RKBIN_VERSION))
RKBIN_LICENSE = nonfree
RKBIN_LICENSE_FILES = LICENSE.TXT

define HOST_RKBIN_INSTALL_CMDS
        $(INSTALL) -D -m 0755 $(@D)/tools/loaderimage $(HOST_DIR)/bin
		mkdir -p $(HOST_DIR)/share/rkfirmware
        $(INSTALL) -D -m 0666 $(@D)/rk32/rk322x_miniloader_v2.56.bin $(HOST_DIR)/share/rkfirmware
        $(INSTALL) -D -m 0666 $(@D)/rk32/rk322x_ddr3_600MHz_ddr2_330MHz_v1.10.bin $(HOST_DIR)/share/rkfirmware
        $(INSTALL) -D -m 0666 $(@D)/rk32/rk3228_tee_ta-51.1.0-333-gc9d95d1.bin $(HOST_DIR)/share/rkfirmware
endef

define RKBIN_PERMISSIONS
       /bin/loaderimage f 4755 0 0 - - - - - 
	   /share/rkfirmware/rk322x_miniloader_v2.56.bin f 0666 0 0 - - - - - 
	   /share/rkfirmware/rk322x_ddr3_600MHz_ddr2_330MHz_v1.10.bin f 0666 0 0 - - - - - 
	   /share/rkfirmware/rk3228_tee_ta-51.1.0-333-gc9d95d1.bin f 0666 0 0 - - - - - 
endef

$(eval $(host-generic-package))

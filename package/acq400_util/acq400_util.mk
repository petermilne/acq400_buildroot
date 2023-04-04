################################################################################
#
# acq400_util
#
################################################################################

ACQ400_UTIL_VERSION = 1.4
ACQ400_UTIL_SITE = $(call github,petermilne,acq400_utils,V$(ACQ400_UTIL_VERSION))
ACQ400_UTIL_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_POPT),y)
    ACQ400_UTIL_DEPENDENCIES += popt
endif

ifeq ($(BR2_PACKAGE_TINYXML),y)
    ACQ400_UTIL_DEPENDENCIES += tinyxml
endif

define ACQ400_UTIL_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" LD="$(TARGET_LD)" -C $(@D) all
endef

define ACQ400_UTIL_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/fs2xml $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/ob_calc_527 $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/daemon $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/xiloader $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/dump-cstrings $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/xml_lookup $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))

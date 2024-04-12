################################################################################
#
# conti-bootloader
#
################################################################################

CONTI_BOOTLOADER_VERSION = main
CONTI_BOOTLOADER_SITE = https://github-vni.geo.conti.de/uid65047/generic_bootloader.git
CONTI_BOOTLOADER_SITE_METHOD = git

CONTI_BOOTLOADER_LICENSE = PROPRIETARY
CONTI_BOOTLOADER_INSTALL_TARGET = NO
CONTI_BOOTLOADER_INSTALL_IMAGES = YES

CONTI_BOOTLOADER_BOARD = $(call qstrip,$(BR2_TARGET_CONTI_BOOTLOADER_BOARD))
CONTI_BOOTLOADER_OPTS+= ARCH="$(GNU_EFI_PLATFORM)" \
                     CROSS_COMPILE="$(TARGET_CROSS)" \

define CONTI_BOOTLOADER_BUILD_CMDS
        $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) $(CONTI_BOOTLOADER_OPTS) $(CONTI_BOOTLOADER_BOARD)
endef

define CONTI_BOOTLOADER_INSTALL_IMAGES_CMDS
	$(INSTALL) -m 0644 -D $(@D)/CONTI-bootloader.bin \
		$(BINARIES_DIR)/CONTI-bootloader.bin
endef

$(eval $(generic-package))

ifeq ($(BR2_TARGET_CONTI_BOOTLOADER)$(BR_BUILDING),yy)
# we NEED a board name
ifeq ($(CONTI_BOOTLOADER_BOARD),)
$(error No CONTI-bootloader board specified. Check your BR2_TARGET_CONTI_BOOTLOADER settings)
endif
endif

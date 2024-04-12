################################################################################
#
# mmc-tools
#
################################################################################

MMC_TOOLS_VERSION = origin/master
MMC_TOOLS_SITE = git@github-vni.geo.conti.de:uic56995/mmc-tools.git
MMC_TOOLS_SITE_METHOD = git
MMC_TOOLS_LICENSE = GPL-2.0
MMC_TOOLS_LICENSE_FILES = mmc.h

MMC_TOOLS_CFLAGS = $(TARGET_CFLAGS)

ifeq ($(BR2_PACKAGE_MMC_TOOLS_ENABLE_DANGEROUS_COMMANDS),y)
MMC_TOOLS_CFLAGS += -DDANGEROUS_COMMANDS_ENABLED
endif

# override AM_CFLAGS as the project Makefile uses it to pass
# -D_FILE_OFFSET_BITS=64 -D_FORTIFY_SOURCE=2, and the latter conflicts
# with the _FORTIFY_SOURCE that we pass when hardening options are
# enabled.
define MMC_TOOLS_BUILD_CMDS
	$(MAKE) -C $(@D) $(TARGET_CONFIGURE_OPTS) \
		CFLAGS="$(MMC_TOOLS_CFLAGS)" \
		AM_CFLAGS=
endef

define MMC_TOOLS_INSTALL_TARGET_CMDS
	$(MAKE) -C $(@D) prefix=/usr DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))

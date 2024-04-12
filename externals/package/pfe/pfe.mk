################################################################################
#
# PFE
#
################################################################################

PFE_VERSION = PFE-DRV_S32G_A53_LINUX_1.1.1_CD01
PFE_SITE = https://github.com/nxp-auto-linux/pfeng.git
PFE_SOURCE = PFE-DRV_S32G_A53_LINUX_1.1.1_CD01.tar.xz
PFE_LICENSE = GPL-2.0
PFE_LICENSE_FILES = COPYING
#PFE_SITE_METHOD = git
PFE_SUBDIRS = sw/linux-pfeng
PFE_MAKE_OPTS = KVERSION=$(LINUX_VERSION_PROBED)

PFE_CONF_OPTS = += \
	KERNELDIR=$(LINUX_DIR) \
	V=1 \
	PFE_CFG_PFE_MASTER=1 \
	PFE_CFG_IP_VERSION=PFE_CFG_IP_VERSION_NPU_7_14a
PFE_MASTER_MAKE_OPTS += \
    KERNELDIR=$(LINUX_DIR) \
    MDIR=$(@D)/sw/linux-pfeng \
    PLATFORM=aarch64-fsl-linux \
    CC=$(TARGET_CROSS)gcc \
    LD=$(TARGET_CROSS)ld \
    V=1 \
    PFE_CFG_MULTI_INSTANCE_SUPPORT=1 \
    BUILD_PROFILEBUILD_PROFILE=debug \
    PFE_CFG_VERBOSITY_LEVEL=10 \
    TARGET_OS=LINUX \
    PFE_CFG_PFE_MASTER=1 \
    PFE_CFG_IP_VERSION=PFE_CFG_IP_VERSION_NPU_7_14a
    PFE_SUPPORTED_REV=PFE_CFG_IP_VERSION_NPU_7_14a
	
PFE_SLAVE_MAKE_OPTS += \
    KERNELDIR=$(LINUX_DIR) \
    MDIR=$(@D)/sw/linux-pfeng \
    PLATFORM=aarch64-fsl-linux \
    CC=$(TARGET_CROSS)gcc \
    LD=$(TARGET_CROSS)ld \
    V=1 \
    PFE_CFG_MULTI_INSTANCE_SUPPORT=1 \
    PFE_CFG_PFE_MASTER=0 \
    PFE_CFG_IP_VERSION=PFE_CFG_IP_VERSION_NPU_7_14a


define PFE_BUILD_CMDS
cd $(@D)/sw/linux-pfeng
$(MAKE) $(PFE_MASTER_MAKE_OPTS)  -C $(@D)/sw/linux-pfeng drv-build
#$(MAKE) $(PFE_SLAVE_MAKE_OPTS)  -C $(@D)/sw/linux-pfeng drv-build
endef

#$(eval $(kernel-module))
$(eval $(generic-package))

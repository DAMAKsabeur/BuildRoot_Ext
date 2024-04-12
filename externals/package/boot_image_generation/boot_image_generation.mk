################################################################################
#
# BOOT_IMAGE_GENERATION
#
################################################################################

BOOT_IMAGE_GENERATION_VERSION = origin/1.0-dev
BOOT_IMAGE_GENERATION_SITE = git@github-vni.geo.conti.de:bs-g-nd-ptf-hpc-gen2/boot_image_generation.git
BOOT_IMAGE_GENERATION_SITE_METHOD = git

BOOT_IMAGE_GENERATION_INSTALL_STAGING = YES
BOOT_IMAGE_GENERATION_LICENSE = BSD-Style
BOOT_IMAGE_GENERATION_LICENSE_FILES = COPYING.txt
HOST_BOOT_IMAGE_GENERATION_DEPENDENCIES = host-python-pycryptodomex
define HOST_BOOT_IMAGE_GENERATION_INSTALL_CMDS
	@echo "hammadi >>>>>>>>>>>"
	
    #if [ -d "$(HOST_DIR)/boot_image_generation" ]; then
    #   echo "'$DIR' found and now copying files, please wait ..."
    #else
    #   echo "Warning: '$DIR' NOT found."
    #   mkdir $(HOST_DIR)/boot_image_generation
    #fi
    #[ ! -d "$(HOST_DIR)/boot_image_generation" ] && mkdir -p "$(HOST_DIR)/boot_image_generation"
	$(INSTALL) -m 0755 -D $(@D)/dev_keys/continental/authentication/boot_mode_key.dat                        $(HOST_DIR)/boot_image_generation/dev_keys/continental/authentication/boot_mode_key.dat
	$(INSTALL) -m 0755 -D $(@D)/dev_keys/continental/pdx_logical_blocks/conti_private_pcu_piu_lb.pem         $(HOST_DIR)/boot_image_generation/dev_keys/continental/pdx_logical_blocks/conti_private_pcu_piu_lb.pem
	$(INSTALL) -m 0755 -D $(@D)/dev_keys/continental/pdx_logical_blocks/conti_public_pcu_piu_lb.pem          $(HOST_DIR)/boot_image_generation/dev_keys/continental/pdx_logical_blocks/conti_public_pcu_piu_lb.pem
	$(INSTALL) -m 0755 -D $(@D)/dev_keys/continental/second_stage_bootloader/conti_pcu_oem_boot_secd_pub.pem $(HOST_DIR)/boot_image_generation/dev_keys/continental/second_stage_bootloader/conti_pcu_oem_boot_secd_pub.pem
	$(INSTALL) -m 0755 -D $(@D)/dev_keys/continental/second_stage_bootloader/conti_pcu_oem_boot_secd_pvt.pem $(HOST_DIR)/boot_image_generation/dev_keys/continental/second_stage_bootloader/conti_pcu_oem_boot_secd_pvt.pem

	$(INSTALL) -m 0755 -D $(@D)/dev_keys/renault/diag_sa/engkey_pairkey_protokey_rsa2048_diaghardening.pem  $(HOST_DIR)/boot_image_generation/dev_keys/renault/diag_sa/engkey_pairkey_protokey_rsa2048_diaghardening.pem
    $(INSTALL) -m 0755 -D $(@D)/dev_keys/renault/diag_sa/engkey_public_protokey_rsa2048_diaghardening.pem   $(HOST_DIR)/boot_image_generation/dev_keys/renault/diag_sa/engkey_public_protokey_rsa2048_diaghardening.pem
    
    $(INSTALL) -m 0755 -D $(@D)/dev_keys/renault/fota/descmo_pub_sit.pem  $(HOST_DIR)/boot_image_generation/dev_keys/renault/fota/descmo_pub_sit.pem
	$(INSTALL) -m 0755 -D $(@D)/dev_keys/renault/fota/descmo_pub_stg.pem  $(HOST_DIR)/boot_image_generation/dev_keys/renault/fota/descmo_pub_stg.pem
	$(INSTALL) -m 0755 -D $(@D)/dev_keys/renault/fota/gw_bi_key_sit.pem   $(HOST_DIR)/boot_image_generation/dev_keys/renault/fota/gw_bi_key_sit.pem
	$(INSTALL) -m 0755 -D $(@D)/dev_keys/renault/fota/scomo_pub_sit.pem   $(HOST_DIR)/boot_image_generation/dev_keys/renault/fota/scomo_pub_sit.pem
	$(INSTALL) -m 0755 -D $(@D)/dev_keys/renault/fota/scomo_pub_stg.pem   $(HOST_DIR)/boot_image_generation/dev_keys/renault/fota/scomo_pub_stg.pem
	
	$(INSTALL) -m 0755 -D $(@D)/dev_keys/renault/pdx_logical_blocks/renault_private_pcu_piu_lb.pem  $(HOST_DIR)/boot_image_generation/dev_keys/renault/pdx_logical_blocks/renault_private_pcu_piu_lb.pem
	$(INSTALL) -m 0755 -D $(@D)/dev_keys/renault/pdx_logical_blocks/renault_public_pcu_piu_lb.pem   $(HOST_DIR)/boot_image_generation/dev_keys/renault/pdx_logical_blocks/renault_public_pcu_piu_lb.pem

	$(INSTALL) -m 0755 -D $(@D)/dev_keys/renault/second_stage_bootloader/renault_pcu_oem_boot_secd_pub.pem  $(HOST_DIR)/boot_image_generation/dev_keys/renault/second_stage_bootloader/renault_pcu_oem_boot_secd_pub.pem
	$(INSTALL) -m 0755 -D $(@D)/dev_keys/renault/second_stage_bootloader/renault_pcu_oem_boot_secd_pvt.pem  $(HOST_DIR)/boot_image_generation/dev_keys/renault/second_stage_bootloader/renault_pcu_oem_boot_secd_pvt.pem
	
	$(INSTALL) -m 0755 -D $(@D)/config/img_config_default.json $(HOST_DIR)/boot_image_generation/config/img_config_default.json
	$(INSTALL) -m 0755 -D $(@D)/config/img_keys_default.json   $(HOST_DIR)/boot_image_generation/config/img_keys_default.json
	$(INSTALL) -m 0755 -D $(@D)/config/keys.json               $(HOST_DIR)/boot_image_generation/config/keys.json
	
	$(INSTALL) -m 0755 -D $(@D)/scripts/config.py        $(HOST_DIR)/boot_image_generation/scripts/config.py
	$(INSTALL) -m 0755 -D $(@D)/scripts/create_keys.py   $(HOST_DIR)/boot_image_generation/scripts/create_keys.py
	$(INSTALL) -m 0755 -D $(@D)/scripts/gen_bimg.py      $(HOST_DIR)/boot_image_generation/scripts/gen_bimg.py
	$(INSTALL) -m 0755 -D $(@D)/scripts/generate_keys.py $(HOST_DIR)/boot_image_generation/scripts/generate_keys.py
	$(INSTALL) -m 0755 -D $(@D)/scripts/make_bimg.sh     $(HOST_DIR)/boot_image_generation/scripts/make_bimg.sh
	$(INSTALL) -m 0755 -D $(@D)/scripts/sign_bccert.py   $(HOST_DIR)/boot_image_generation/scripts/sign_bccert.py
	$(INSTALL) -m 0755 -D $(@D)/scripts/sign.py          $(HOST_DIR)/boot_image_generation/scripts/sign.py
endef

$(eval $(host-generic-package))

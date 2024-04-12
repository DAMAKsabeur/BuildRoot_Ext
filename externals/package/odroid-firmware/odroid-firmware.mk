################################################################################
#
# odroid-firmware
#
################################################################################

#~ ODROID_FIRMWARE_VERSION = main
#~ ODROID_FIRMWARE_SITE = https://github.com/DAMAKsabeur/odroid-firmware.git
ODROID_FIRMWARE_VERSION = HEAD
ODROID_FIRMWARE_SITE = $(call github,DAMAKsabeur,odroid-firmware,$(ODROID_FIRMWARE_VERSION))
ODROID_FIRMWARE_INSTALL_IMAGES = YES
#~ ODROID_FIRMWARE_DEPENDENCIES = u-boot
define ODROID_FIRMWARE_BUILD_CMDS
    rm -rf  $(@D)/output/
    mkdir $(@D)/output/
    sh $(@D)/odroid-c4/blx_fix.sh $(@D)/odroid-c4/bl30.bin $(@D)/output/zero_tmp $(@D)/output/bl30_zero.bin $(@D)/odroid-c4/bl301.bin $(@D)/output/bl301_zero.bin $(@D)/output/bl30_new.bin bl30
    sh $(@D)/odroid-c4/blx_fix.sh $(@D)/odroid-c4/bl2.bin $(@D)/output/zero_tmp $(@D)/output/bl2_zero.bin $(@D)/odroid-c4/acs.bin $(@D)/output/bl21_zero.bin $(@D)/output/bl2_new.bin bl2
    $(INSTALL) -D -m 0644 $(BINARIES_DIR)/u-boot.bin $(@D)/output/
    $(INSTALL) -D -m 0777  $(@D)/odroid-c4/aml_encrypt_g12a $(@D)/output/
	$(@D)/output/aml_encrypt_g12a --bl30sig --input $(@D)/output/bl30_new.bin \
                                      --output $(@D)/output/bl30_new.bin.g12a.enc \
                                      --level v3
    $(@D)/output/aml_encrypt_g12a --bl3sig --input $(@D)/output/bl30_new.bin.g12a.enc \
                              --output $(@D)/output/bl30_new.bin.enc \
                              --level v3 --type bl30
    $(@D)/output/aml_encrypt_g12a --bl3sig --input $(@D)/odroid-c4/bl31.img \
                              --output $(@D)/output/bl31.img.enc \
                              --level v3 --type bl31
    $(@D)/output/aml_encrypt_g12a --bl3sig --input $(@D)/output/u-boot.bin --compress lz4 \
                              --output $(@D)/output/u-boot.bin.enc \
                              --level v3 --type bl33 --compress lz4
    $(@D)/output/aml_encrypt_g12a --bl2sig --input $(@D)/output/bl2_new.bin \
                              --output $(@D)/output/bl2.n.bin.sig
    $(@D)/output/aml_encrypt_g12a --bootmk \
                                          --output $(@D)/output/boot-strap-tmp.bin \
                                          --bl2 $(@D)/output/bl2.n.bin.sig \
                                          --bl30 $(@D)/output/bl30_new.bin.enc \
                                          --bl31 $(@D)/output/bl31.img.enc \
                                          --bl33 $(@D)/output/u-boot.bin.enc \
                                          --ddrfw1 $(@D)/odroid-c4/ddr4_1d.fw \
                                          --ddrfw2 $(@D)/odroid-c4/ddr4_2d.fw \
                                          --ddrfw3 $(@D)/odroid-c4/ddr3_1d.fw \
                                          --ddrfw4 $(@D)/odroid-c4/piei.fw \
                                          --ddrfw5 $(@D)/odroid-c4/lpddr4_1d.fw \
                                          --ddrfw6 $(@D)/odroid-c4/lpddr4_2d.fw \
                                          --ddrfw7 $(@D)/odroid-c4/diag_lpddr4.fw \
                                          --ddrfw8 $(@D)/odroid-c4/aml_ddr.fw \
                                          --ddrfw9 $(@D)/odroid-c4/lpddr3_1d.fw \
                                          --level v3
    dd if=/dev/zero of=$(@D)/output/bootstrap.bin bs=512 count=4096
    #dd if=/dev/zero ibs=512 count=4096 | LC_ALL=C tr "\000" "\377" >$(@D)/output/boot-strap.bin
    dd if=$(@D)/output/boot-strap-tmp.bin.sd.bin of=$(@D)/output/bootstrap.bin conv=fsync,notrunc bs=512 skip=1 seek=1
    dd if=$(@D)/output/boot-strap-tmp.bin.sd.bin of=$(@D)/output/bootstrap.bin conv=fsync,notrunc bs=1 count=440
endef

ODROID_FIRMWARE_FILES = \
    output/bootstrap.bin

define ODROID_FIRMWARE_INSTALL_IMAGES_CMDS
	$(foreach f,$(ODROID_FIRMWARE_FILES), \
		$(INSTALL) -D -m 0644 $(@D)/$(f) $(BINARIES_DIR)/$(notdir $(f))
	)
endef

$(eval $(generic-package))

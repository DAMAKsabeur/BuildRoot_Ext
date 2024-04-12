#!/bin/sh

BOARD_DIR="$(dirname $0)"
echo "ODROIDC4-UBOOT-CONFIG"
rm ${BINARIES_DIR}/full_sd_image.bin
#dd if=${BINARIES_DIR}/u-boot.bin of=${BINARIES_DIR}/sdcard.img bs=512 seek=1 conv=fsync,notrunc
dd if=/dev/zero of=${BINARIES_DIR}/full_sd_image.bin bs=1M count=300
dd if=${BINARIES_DIR}/bootstrap.bin of=${BINARIES_DIR}/full_sd_image.bin bs=512 conv=fsync,notrunc
dd if=${BINARIES_DIR}/uboot-env.bin of=${BINARIES_DIR}/full_sd_image.bin bs=512 seek=$((0x200000/0x200)) conv=fsync,notrunc
dd if=${BINARIES_DIR}/Image of=${BINARIES_DIR}/full_sd_image.bin bs=512 seek=$((0x202000/0x200)) conv=fsync,notrunc
dd if=${BINARIES_DIR}/meson64_odroidc4.dtb of=${BINARIES_DIR}/full_sd_image.bin bs=512 seek=$((0x2002000/0x200)) conv=fsync,notrunc
dd if=${BINARIES_DIR}/rootfs.cpio.uboot of=${BINARIES_DIR}/full_sd_image.bin bs=512 seek=$((0x201B000/0x200)) conv=fsync,notrunc

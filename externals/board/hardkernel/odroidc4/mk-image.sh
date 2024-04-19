dd if=/dev/zero of=images/full_sd_image.bin bs=1M count=10
#~ count=250
dd if=images/bootstrap.bin of=images/full_sd_image.bin bs=1 conv=fsync,notrunc
dd if=images/uboot-env.bin of=images/full_sd_image.bin bs=1 seek=$((0x200000)) conv=fsync,notrunc
#~ dd if=images/Image of=images/full_sd_image.bin bs=1 seek=$((0x202000)) conv=fsync,notrunc
#~ dd if=images/meson64_odroidc4.dtb of=images/full_sd_image.bin bs=1 seek=$((0x2002000)) conv=fsync,notrunc
#~ dd if=images/rootfs.cpio.uboot of=images/full_sd_image.bin bs=1 seek=$((0x201B000)) conv=fsync,notrunc

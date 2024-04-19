ifeq ($(BR2_TARGET_ROOTFS_NFS),y)
TARGETS_ROOTFS += rootfs-nfs
endif

define ROOTFS_NFS_CMD
    if [ ! -d $(BR2_TARGET_ROOTFS_NFS_PATH) ]
    then 
        mkdir -p $(BR2_TARGET_ROOTFS_NFS_PATH) 
    fi
#~ 	rsync -rtvpl  $(TARGET_DIR)/*  $(BR2_TARGET_ROOTFS_NFS_PATH)
#~ 	chmod 777 -R $(BR2_TARGET_ROOTFS_NFS_PATH)
	tar -xavf $(BINARIES_DIR)/rootfs.tar -C $(BR2_TARGET_ROOTFS_NFS_PATH) 
endef

$(eval $(rootfs))

ifeq ($(BR2_TARGET_ROOTFS_NFS),y)
TARGETS_ROOTFS += rootfs-nfs
endif

define ROOTFS_NFS_CMD
    if [ ! -d $(BR2_TARGET_ROOTFS_NFS_PATH) ]
    then 
        mkdir -p $(BR2_TARGET_ROOTFS_NFS_PATH) 
    fi
	rsync -r $(TARGET_DIR)/*  $(BR2_TARGET_ROOTFS_NFS_PATH)
endef

$(eval $(rootfs))

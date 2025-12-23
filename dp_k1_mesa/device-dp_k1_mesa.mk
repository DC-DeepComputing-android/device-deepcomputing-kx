# Kernel
ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := device/deepcomputing/k1-kernel/kernel-6.1/Image
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

# k1-x_deb1.dtb used for new BOARD
# k1-x_deb2.dtb used for OLD board
# k1-x_kx107.dtb used for PAD
ifeq ($(TARGET_PREBUILT_DTB), )
LOCAL_DTB := device/deepcomputing/k1-kernel/kernel-6.1/k1-x_kx107.dtb
else
LOCAL_DTB := $(TARGET_PREBUILT_DTB)
endif

PRODUCT_COPY_FILES := \
    $(LOCAL_KERNEL):kernel \

# FIXME API_LEVEL 32 required manifest fcm verison ge 6, but now is 3
DEVICE_MANIFEST_FILE += \
    device/deepcomputing/kx/manifest_dp_k1_mesa.xml

# k1 init files
PRODUCT_COPY_FILES += \
    $(LOCAL_DP_DIR)/dp_k1/init.k1.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.k1.rc \
    $(LOCAL_DP_DIR)/dp_k1/init.usb.k1.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.usb.k1.rc \
    $(LOCAL_DP_DIR)/dp_k1/init.connectivity.k1.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.connectivity.k1.rc \
    $(LOCAL_DP_DIR)/dp_k1/ueventd.k1.rc:$(TARGET_COPY_OUT_VENDOR)/etc/ueventd.rc \

# k1 fstab files
PRODUCT_COPY_FILES += \
    $(LOCAL_DP_DIR)/dp_k1/fstab.ramdisk.k1:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.k1 \
    $(LOCAL_DP_DIR)/dp_k1/fstab.k1:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.k1 \
    $(LOCAL_DP_DIR)/dp_k1/fstab.ramdisk.k1:$(TARGET_COPY_OUT_RAMDISK)/fstab.k1 \
    $(LOCAL_DP_DIR)/dp_k1/fstab.enableswap:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.enableswap \

#k1 firmware files
PRODUCT_COPY_FILES += \
    device/deepcomputing/k1-kernel/kernel-6.1/firmware/esos.elf:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/firmware/esos.elf \
    device/deepcomputing/kx/gpu/rgx.fw.36.29.52.182:$(TARGET_COPY_OUT_VENDOR)/firmware/rgx.fw.36.29.52.182 \
    device/deepcomputing/kx/gpu/rgx.sh.36.29.52.182:$(TARGET_COPY_OUT_VENDOR)/firmware/rgx.sh.36.29.52.182 \

# Recovery files
PRODUCT_COPY_FILES += \
    $(LOCAL_DP_DIR)/dp_k1/init.recovery.k1.rc:recovery/root/init.recovery.k1.rc \

# k1 media configurations
PRODUCT_COPY_FILES += \
    $(LOCAL_DP_DIR)/dp_k1/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_video.xml \

## Will check later - XC-TODO
    #$(LOCAL_DP_DIR)/dp_k1/media_codecs_hantro_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_hantro_video.xml \
    #$(LOCAL_DP_DIR)/dp_k1/media_codecs_performance.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance.xml \

PRODUCT_COPY_FILES += \
    system/core/libprocessgroup/profiles/cgroups.json:$(TARGET_COPY_OUT_VENDOR)/etc/cgroups.json \
    system/core/libprocessgroup/profiles/task_profiles.json:$(TARGET_COPY_OUT_VENDOR)/etc/task_profiles.json

#######  SYSTEM INFO  ########
# Set system properties identifying the chipset
PRODUCT_VENDOR_PROPERTIES += ro.soc.manufacturer=k1
PRODUCT_VENDOR_PROPERTIES += ro.soc.model=k1

PRODUCT_PRODUCT_PROPERTIES += \
    ro.product.k1.version=RV64.Android.$(PLATFORM_VERSION_LAST_STABLE).alpha.V0.1


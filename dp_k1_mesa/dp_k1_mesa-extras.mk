# Load k1 feature config
#$(call inherit-product, $(LOCAL_DP_DIR)/dp_k1/feature_config.mk)

PRODUCT_COPY_FILES += $(LOCAL_DP_DIR)/dp_k1/android.software.k1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.xml
PRODUCT_COPY_FILES += $(LOCAL_DP_DIR)/dp_k1/android.hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.xml

# Installs gsi keys into ramdisk, to boot a developer GSI with verified boot.
#$(call inherit-product, $(SRC_TARGET_DIR)/product/developer_gsi_keys.mk)

# Set Vendor SPL to match platform
#VENDOR_SECURITY_PATCH = $(PLATFORM_SECURITY_PATCH)

# Set boot SPL
#BOOT_SECURITY_PATCH = $(PLATFORM_SECURITY_PATCH)

# fastbootd
PRODUCT_PACKAGES += \
    fastbootd \

PRODUCT_PACKAGES_DEBUG += \
    sg_write_buffer \
    f2fs_io \
    check_f2fs

#XC-TODO:?
PRODUCT_PACKAGES += \
    linker.vendor_ramdisk \
    e2fsck.vendor_ramdisk \

# Input Classifier HAL
PRODUCT_PACKAGES += \
    android.hardware.input.classifier@1.0-service.default

# Reboot escrow
PRODUCT_PACKAGES += \
    android.hardware.rebootescrow-service.default


# Enable APK Verity, which depends on fs-verity support in kernel.
PRODUCT_PROPERTY_OVERRIDES += ro.apk_verity.mode=2

# Reduces GC frequency of foreground apps by 50%
PRODUCT_PROPERTY_OVERRIDES += dalvik.vm.foreground-heap-growth-multiplier=2.0

# Use FUSE passthrough
PRODUCT_PRODUCT_PROPERTIES += \
    persist.sys.fuse.passthrough.enable=true

# Enable DM file pre-opting to reduce first boot time
#PRODUCT_DEX_PREOPT_GENERATE_DM_FILES :=true

#PRODUCT_DEX_PREOPT_DEFAULT_COMPILER_FILTER := verify

# k1 permission configurations
#PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml \



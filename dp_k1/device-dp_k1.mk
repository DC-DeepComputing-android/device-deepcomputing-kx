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

LOCAL_DP_DIR := device/deepcomputing/kx
# Load k1 feature config
#$(call inherit-product, $(LOCAL_DP_DIR)/dp_k1/feature_config.mk)

# Overlay
# TODO: if we need some overlays
#DEVICE_PACKAGE_OVERLAYS := $(LOCAL_DP_DIR)/dp_k1/overlay

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

# Recovery files
PRODUCT_COPY_FILES += \
    $(LOCAL_DP_DIR)/dp_k1/init.recovery.k1.rc:recovery/root/init.recovery.k1.rc \

#AVB public key
PRODUCT_COPY_FILES += \
     $(LOCAL_DP_DIR)/keys/kx_public.bin:$(TARGET_COPY_OUT_RAMDISK)/avb/kx.avbpubkey \
     $(LOCAL_DP_DIR)/keys/kx_public.bin:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/avb/kx.avbpubkey \

# k1 media configurations
PRODUCT_COPY_FILES += \
    $(LOCAL_DP_DIR)/dp_k1/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_video.xml \

## Will check later - XC-TODO
    #$(LOCAL_DP_DIR)/dp_k1/media_codecs_hantro_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_hantro_video.xml \
    #$(LOCAL_DP_DIR)/dp_k1/media_codecs_performance.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance.xml \

# k1 permission configurations
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml \

PRODUCT_COPY_FILES += $(LOCAL_DP_DIR)/dp_k1/android.software.k1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.xml
PRODUCT_COPY_FILES += $(LOCAL_DP_DIR)/dp_k1/android.hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.xml

# ethernet #
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.ethernet.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.ethernet.xml

# Wi-Fi
BOARD_VENDOR_KERNEL_MODULES += device/deepcomputing/k1-kernel/kernel-6.1/cfg80211.ko \
    device/deepcomputing/k1-kernel/kernel-6.1/8852be.ko

# WiFi HAL
PRODUCT_PACKAGES += \
    android.hardware.wifi-service \
    android.hardware.wifi.hostapd \
    android.hardware.wifi.supplicant \
    wificond

PRODUCT_PACKAGES += \
    hostapd \
    hostapd_cli \
    wpa_supplicant \
    wpa_cli \
    wpa_supplicant.conf \
    libwpa_client \
    wifilogd \
    hostapd.conf \
    libwifi-hal \

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.passpoint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.passpoint.xml \
    $(LOCAL_DP_DIR)/supplicant_overlay_config/wpa_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant_overlay.conf \
    $(LOCAL_DP_DIR)/supplicant_overlay_config/p2p_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/p2p_supplicant_overlay.conf \

PRODUCT_PROPERTY_OVERRIDES += \
    wifi.interface=wlan0 \
    wifi.direct.interface=p2p0 \
# Bluetooth
# rtkbt
BOARD_HAVE_BLUETOOTH_RTK := true
$(call inherit-product, hardware/realtek/bt/rtkbt/rtkbt.mk)

BOARD_VENDOR_KERNEL_MODULES += device/deepcomputing/k1-kernel/kernel-6.1/bluetooth.ko \
    device/deepcomputing/k1-kernel/kernel-6.1/btrtl.ko \
    device/deepcomputing/k1-kernel/kernel-6.1/rtk_btusb.ko

# use bt controller efuse mac
PRODUCT_PRODUCT_PROPERTIES += \
    persist.vendor.rtkbt.bdaddr_path=none

# The device supports verified boot
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.verified_boot.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.verified_boot.xml

# USB properties
PRODUCT_VENDOR_PROPERTIES += \
   ro.boot.usb_mode=1 \
   ro.boot.usb_speed=5

# Display lcd denstity(TODO)
TARGET_SCREEN_DENSITY := 280


# Installs gsi keys into ramdisk, to boot a developer GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/developer_gsi_keys.mk)

# Set Vendor SPL to match platform
VENDOR_SECURITY_PATCH = $(PLATFORM_SECURITY_PATCH)

# Set boot SPL
BOOT_SECURITY_PATCH = $(PLATFORM_SECURITY_PATCH)

# product.img
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_PRODUCT := product

# system_ext.img
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_SYSTEM_EXT := system_ext

#vendor_ramdisk.img
BOARD_BUILD_VENDOR_RAMDISK_IMAGE := true
#XC-TODO:?
PRODUCT_PACKAGES += \
    linker.vendor_ramdisk \
    e2fsck.vendor_ramdisk \

AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += vendor
AB_OTA_PARTITIONS += boot
AB_OTA_PARTITIONS += init_boot
AB_OTA_PARTITIONS += vendor_boot
AB_OTA_PARTITIONS += product
AB_OTA_PARTITIONS += system
AB_OTA_PARTITIONS += vbmeta_system
AB_OTA_PARTITIONS += system_ext
AB_OTA_PARTITIONS += vbmeta

# Fix cts bug CtsThemeHostTestCases about xhdpi assets missing
PRODUCT_AAPT_PREF_CONFIG := xhdpi

# Enable APK Verity, which depends on fs-verity support in kernel.
PRODUCT_PROPERTY_OVERRIDES += ro.apk_verity.mode=2

# Reduces GC frequency of foreground apps by 50%
PRODUCT_PROPERTY_OVERRIDES += dalvik.vm.foreground-heap-growth-multiplier=2.0

PRODUCT_COPY_FILES += \
    system/core/libprocessgroup/profiles/cgroups.json:$(TARGET_COPY_OUT_VENDOR)/etc/cgroups.json \
    system/core/libprocessgroup/profiles/task_profiles.json:$(TARGET_COPY_OUT_VENDOR)/etc/task_profiles.json

# fastbootd
PRODUCT_PACKAGES += \
    fastbootd \


# XC-TODO: services, all these three
# Dumpstate HAL
#PRODUCT_PACKAGES += android.hardware.dumpstate@1.1-service.k1

# Atrace HAL
#PRODUCT_PACKAGES += android.hardware.atrace@1.0-service.k1

# OemLock aidl HAL
#PRODUCT_PACKAGES += android.hardware.oemlock-service.k1

#
# Authsecret HAL
#
PRODUCT_PACKAGES += \
    android.hardware.authsecret@1.0-service

#
# Authsecret AIDL HAL
#
PRODUCT_PACKAGES += \
    android.hardware.authsecret-service.example

# Input Classifier HAL
PRODUCT_PACKAGES += \
    android.hardware.input.classifier@1.0-service.default

# Reboot escrow
PRODUCT_PACKAGES += \
    android.hardware.rebootescrow-service.default

# Bluetooth HAL
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.0-impl \
    android.hardware.bluetooth@1.0-service

# block_audio
USE_XML_AUDIO_POLICY_CONF := 1
PRODUCT_PACKAGES += \
    android.hardware.audio@7.1-impl \
    android.hardware.audio.service \
    android.hardware.audio.effect@7.0-impl:32

PRODUCT_PACKAGES += \
    android.hardware.bluetooth.audio-impl \
    audio.bluetooth.default \
    audio.usb.default \
    tinycap \
    tinymix \
    tinyplay \
    tinypcminfo \

PRODUCT_COPY_FILES += \
    $(LOCAL_DP_DIR)/dp_k1/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/a2dp_in_audio_policy_configuration_7_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_in_audio_policy_configuration_7_0.xml \
    frameworks/av/services/audiopolicy/config/bluetooth_audio_policy_configuration_7_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_audio_policy_configuration_7_0.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml \
    frameworks/native/data/etc/android.hardware.audio.output.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.output.xml \

# Set system properties identifying the chipset
PRODUCT_VENDOR_PROPERTIES += ro.soc.manufacturer=k1
PRODUCT_VENDOR_PROPERTIES += ro.soc.model=k1

PRODUCT_PACKAGES_DEBUG += \
    sg_write_buffer \
    f2fs_io \
    check_f2fs

# Use FUSE passthrough
PRODUCT_PRODUCT_PROPERTIES += \
    persist.sys.fuse.passthrough.enable=true

# Fix cts bug CtsNativeVerifiedBootTestCases
PRODUCT_PRODUCT_PROPERTIES += \
    partition.system.verified.hash_alg=$(BOARD_AVB_VBMETA_SYSTEM_ALGORITHM) \
    partition.system_ext.verified.hash_alg=$(BOARD_AVB_VBMETA_SYSTEM_ALGORITHM) \
    partition.vendor.verified.hash_alg=$(BOARD_AVB_VBMETA_SYSTEM_ALGORITHM) \
    partition.product.verified.hash_alg=$(BOARD_AVB_VBMETA_SYSTEM_ALGORITHM) \

PRODUCT_PRODUCT_PROPERTIES += \
    ro.product.k1.version=RV64.Android.$(PLATFORM_VERSION_LAST_STABLE).alpha.V0.1

# Enable DM file pre-opting to reduce first boot time
PRODUCT_DEX_PREOPT_GENERATE_DM_FILES :=true
PRODUCT_DEX_PREOPT_DEFAULT_COMPILER_FILTER := verify

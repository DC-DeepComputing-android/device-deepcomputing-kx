#
# Copyright 2022 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


# Kernel
ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := device/deepcomputing/k1-kernel/andes-6.1/Image
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

ifeq ($(TARGET_PREBUILT_DTB), )
LOCAL_DTB := device/deepcomputing/k1-kernel/andes-6.1/qilai_gpu.dtb
else
LOCAL_DTB := $(TARGET_PREBUILT_DTB)
endif

PRODUCT_COPY_FILES := \
    $(LOCAL_KERNEL):kernel \
    $(LOCAL_DTB):qilai.dtb \


# BootControl HAL
PRODUCT_PACKAGES += \
    android.hardware.boot-service.default \
    android.hardware.boot-service.default_recovery


PRODUCT_PACKAGES += \
	android.hardware.health-service.example \
	android.hardware.health-service.example_recovery \


# Netlink Interceptor HAL
#PRODUCT_PACKAGES += \
#    android.hardware.net.nlinterceptor-service.default


# USB HAL
PRODUCT_PACKAGES += \
    android.hardware.usb-service
PRODUCT_PACKAGES += \
    android.hardware.usb.gadget-service


# XC-TODO: use files under dp_k1
# Recovery files
PRODUCT_COPY_FILES += \
    $(LOCAL_DP_DIR)/dp_k1/init.recovery.k1.rc:recovery/root/init.recovery.andes.rc \


PRODUCT_COPY_FILES += $(LOCAL_DP_DIR)/dp_k1/android.software.k1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.xml
PRODUCT_COPY_FILES += $(LOCAL_DP_DIR)/dp_k1/android.hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.xml


PRODUCT_COPY_FILES += \
    system/core/libprocessgroup/profiles/cgroups.json:$(TARGET_COPY_OUT_VENDOR)/etc/cgroups.json \
    system/core/libprocessgroup/profiles/task_profiles.json:$(TARGET_COPY_OUT_VENDOR)/etc/task_profiles.json


PRODUCT_PACKAGES_DEBUG += \
    sg_write_buffer \
    f2fs_io \
    check_f2fs

# Use FUSE passthrough
PRODUCT_PRODUCT_PROPERTIES += \
    persist.sys.fuse.passthrough.enable=true

# k1 permission configurations
#PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml \

# XC-TODO: services, all these three
# OemLock aidl HAL
#PRODUCT_PACKAGES += android.hardware.oemlock-service.k1


# andes fstab files
PRODUCT_COPY_FILES += \
    $(LOCAL_DP_DIR)/dp_andes/fstab.ramdisk.andes:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.andes \
    $(LOCAL_DP_DIR)/dp_andes/fstab.andes:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.andes \
    $(LOCAL_DP_DIR)/dp_andes/fstab.ramdisk.andes:$(TARGET_COPY_OUT_RAMDISK)/fstab.andes \
    $(LOCAL_DP_DIR)/dp_andes/fstab.enableswap:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.enableswap \


##########################################
#  AVB Part
#########################################
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


# AVB public key
PRODUCT_COPY_FILES += \
     $(LOCAL_DP_DIR)/keys/kx_public.bin:$(TARGET_COPY_OUT_RAMDISK)/avb/kx.avbpubkey \
     $(LOCAL_DP_DIR)/keys/kx_public.bin:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/avb/kx.avbpubkey \

# The device supports verified boot
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.verified_boot.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.verified_boot.xml


# Installs gsi keys into ramdisk, to boot a developer GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/developer_gsi_keys.mk)

# Set Vendor SPL to match platform
VENDOR_SECURITY_PATCH = $(PLATFORM_SECURITY_PATCH)

# Set boot SPL
BOOT_SECURITY_PATCH = $(PLATFORM_SECURITY_PATCH)


#XC-TODO:?
PRODUCT_PACKAGES += \
    linker.vendor_ramdisk \
    e2fsck.vendor_ramdisk \

# Enable APK Verity, which depends on fs-verity support in kernel.
PRODUCT_PROPERTY_OVERRIDES += ro.apk_verity.mode=2

# Fix cts bug CtsNativeVerifiedBootTestCases
PRODUCT_PRODUCT_PROPERTIES += \
    partition.system.verified.hash_alg=$(BOARD_AVB_VBMETA_SYSTEM_ALGORITHM) \
    partition.system_ext.verified.hash_alg=$(BOARD_AVB_VBMETA_SYSTEM_ALGORITHM) \
    partition.vendor.verified.hash_alg=$(BOARD_AVB_VBMETA_SYSTEM_ALGORITHM) \
    partition.product.verified.hash_alg=$(BOARD_AVB_VBMETA_SYSTEM_ALGORITHM) \


# VR HAL
PRODUCT_COPY_FILES += \
    frameworks/native/services/vr/virtual_touchpad/idc/vr-virtual-touchpad-1.idc:$(TARGET_COPY_OUT_VENDOR)/usr/idc/vr-virtual-touchpad-1.idc \
    frameworks/native/data/etc/android.hardware.vr.high_performance.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vr.high_performance.xml \
    frameworks/native/data/etc/android.hardware.vr.headtracking-0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vr.headtracking.xml

PRODUCT_PACKAGES += \
    vr.default \
    android.hardware.vr@1.0-service \
    android.hardware.vr@1.0-impl


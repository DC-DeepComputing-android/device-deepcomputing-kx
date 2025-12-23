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
#

# Keymaster & Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.keymaster@4.0-service \
    android.hardware.security.keymint-service \

    #android.hardware.gatekeeper@1.0-service \
    #android.hardware.gatekeeper@1.0-service.software \
    #android.hardware.gatekeeper@1.0-impl \


# XC-TODO: may change these setting
PRODUCT_PACKAGES += \
    android.hardware.drm@1.0-service \
    android.hardware.drm@1.0-impl \
    android.hardware.drm@1.4-service.clearkey \


# Authsecret HAL
PRODUCT_PACKAGES += \
    android.hardware.authsecret@1.0-service

# Authsecret AIDL HAL
PRODUCT_PACKAGES += \
    android.hardware.authsecret-service.example


# XC_TODO: set BOARD_AVB_BOOT_KEY_PATH
# The device supports verified boot
#PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.verified_boot.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.verified_boot.xml


#AVB public key
#PRODUCT_COPY_FILES += \
     $(LOCAL_DP_DIR)/keys/kx_public.bin:$(TARGET_COPY_OUT_RAMDISK)/avb/kx.avbpubkey \
     $(LOCAL_DP_DIR)/keys/kx_public.bin:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/avb/kx.avbpubkey \

#BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
# Fix cts bug CtsNativeVerifiedBootTestCases
#PRODUCT_PRODUCT_PROPERTIES += \
    partition.system.verified.hash_alg=$(BOARD_AVB_VBMETA_SYSTEM_ALGORITHM) \
    partition.system_ext.verified.hash_alg=$(BOARD_AVB_VBMETA_SYSTEM_ALGORITHM) \
    partition.vendor.verified.hash_alg=$(BOARD_AVB_VBMETA_SYSTEM_ALGORITHM) \
    partition.product.verified.hash_alg=$(BOARD_AVB_VBMETA_SYSTEM_ALGORITHM) \


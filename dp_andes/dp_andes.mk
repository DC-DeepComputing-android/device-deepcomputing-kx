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

# Disable Scudo outside of eng builds to save RAM.
ifneq (,$(filter eng, $(TARGET_BUILD_VARIANT)))
  PRODUCT_DISABLE_SCUDO := true
endif

##########################################
#  common system from $SRC_TARGET_DIR
#########################################
# Control Vars for ALL DP Devices (Must use include if this file include real Ops like PRODUCT_COPY_FILES)
include device/deepcomputing/kx/common/common_dp.mk

# Mini_system
$(call inherit-product, device/deepcomputing/kx/common/mini_system.mk)

# All components inherited here go to product image
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_product.mk)

# All packages in this file are include in 'aosp_product.mk' alreay
$(call inherit-product, device/deepcomputing/kx/common/mini_product.mk)


##########################################
#  Settings for DP devices
#########################################
# Riscv patch for system
$(call inherit-product, device/deepcomputing/kx/common/system_riscv_patch.mk)

# prop for ANDES14 ONLY
include device/deepcomputing/kx/dp_andes/dp_andes_prop.mk


##########################################
#  All subdevs (graphics, audio, net etc)
#########################################
PRODUCT_SOONG_NAMESPACES += \
    device/generic/goldfish \
    external/drm_hwcomposer

# system_ext: optional
$(call inherit-product-if-exist, device/deepcomputing/kx/common/kx_system_ext.mk)

# Enable Scoped Storage related
# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Subdevs packages
$(call inherit-product, device/deepcomputing/kx/common/subdevs_kx.mk)

# AOSP default vendor configs
$(call inherit-product, device/deepcomputing/kx/common/aosp_vendor.mk)

# andes special vendor packages
$(call inherit-product, device/deepcomputing/kx/dp_andes/device-dp_andes.mk)

# andes extra features
$(call inherit-product-if-exist, device/deepcomputing/kx/dp_andes/dp_andes-extras.mk)

# setup dalvik vm configs
include frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk


##########################################
#  PRODUCT INFO
#########################################
## Latest to overwrite all above settings under build/make/target == $(SRC_TARGET_DIR)
PRODUCT_NAME := dp_andes
PRODUCT_DEVICE := dp_andes
PRODUCT_BRAND := Android
PRODUCT_MANUFACTURER := deepcomputing
PRODUCT_MODEL := AOSP on DP_ANDES

# Andes fstab files
PRODUCT_COPY_FILES += \
    $(LOCAL_DP_DIR)/dp_andes/fstab.ramdisk.andes:$(TARGET_COPY_OUT_RAMDISK)/fstab.andes \
    $(LOCAL_DP_DIR)/dp_andes/fstab.andes:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.andes \
    $(LOCAL_DP_DIR)/dp_andes/fstab.enableswap:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.enableswap

# Andes init files
PRODUCT_COPY_FILES += \
    $(LOCAL_DP_DIR)/dp_andes/init.andes.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.andes.rc \
    $(LOCAL_DP_DIR)/dp_andes/init.usb.andes.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.usb.andes.rc \
    $(LOCAL_DP_DIR)/dp_andes/ueventd.andes.rc:$(TARGET_COPY_OUT_VENDOR)/etc/ueventd.andes.rc \
    ## XC_TODO: init.connectivity.k1.rc


PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/Generic.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/Generic.kl \
    $(LOCAL_PATH)/displayconfig/default.xml:$(TARGET_COPY_OUT_VENDOR)/etc/displayconfig/default.xml \
    $(LOCAL_PATH)/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \


PRODUCT_AAPT_PREF_CONFIG := mdpi
#PRODUCT_CHARACTERISTICS := tv
PRODUCT_CHARACTERISTICS := tablet

LOCAL_64ONLY := _64

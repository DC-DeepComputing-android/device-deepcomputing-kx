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

# Disable Scudo outside of eng builds to save RAM.
ifneq (,$(filter eng, $(TARGET_BUILD_VARIANT)))
  PRODUCT_DISABLE_SCUDO := true
endif


##########################################
#  common system from $SRC_TARGET_DIR
#########################################
# common control vars for all dp
$(call inherit-product, device/deepcomputing/kx/common/common_dp.mk)

# mini_system
$(call inherit-product, device/deepcomputing/kx/common/mini_system.mk)

#
# All components inherited here go to product image
#
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_product.mk)

# All packages in this file are include in 'aosp_product.mk' alreay
$(call inherit-product, device/deepcomputing/kx/common/mini_product.mk)


##########################################
#  Settings for Kx devices
#########################################
# Riscv patch for system: check later - XC-TODO
$(call inherit-product, device/deepcomputing/kx/common/system_riscv_patch.mk)

# XC-TODO!! check prop?
# This setting may NOT correct?
PRODUCT_SHIPPING_API_LEVEL := 31  # XC-TODO

##########################################
#  All subdevs (graphics, audio, net etc)
#########################################
PRODUCT_SOONG_NAMESPACES += \
    device/generic/goldfish \
    external/drm_hwcomposer

# system_ext: optional[wwd]
$(call inherit-product-if-exist, device/deepcomputing/kx/common/kx_system_ext.mk)

# Enable Scoped Storage related
# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# subdevs packages
$(call inherit-product, device/deepcomputing/kx/common/subdevs_kx.mk)

# AOSP default vendor configs
$(call inherit-product, device/deepcomputing/kx/common/aosp_vendor.mk)

# k1_mesa special vendor packages
$(call inherit-product, device/deepcomputing/kx/dp_k1_mesa/device-dp_k1_mesa.mk)

# k1_mes extra features
$(call inherit-product, device/deepcomputing/kx/dp_k1_mesa/dp_k1_mesa-extras.mk)

# setup dalvik vm configs
include frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk

##########################################
#  PRODUCT INFO
#########################################
## Latest to overwrite all above settings under build/make/target
PRODUCT_MANUFACTURER := deepcomputing
PRODUCT_BRAND := Android
PRODUCT_NAME := dp_k1_mesa
PRODUCT_DEVICE := dp_k1_mesa
PRODUCT_MODEL := AOSP on DP_K1

PRODUCT_CHARACTERISTICS := tablet


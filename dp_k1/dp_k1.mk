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
LOCAL_64ONLY := _64

# Disable Scudo outside of eng builds to save RAM.
ifneq (,$(filter eng, $(TARGET_BUILD_VARIANT)))
  PRODUCT_DISABLE_SCUDO := true
endif

### All products are controlled by these config files
# mini_system
$(call inherit-product, device/deepcomputing/kx/common/mini_system.mk)

$(call inherit-product, device/deepcomputing/kx/common/mini_product.mk)

# system_ext: optional[wwd]
$(call inherit-product-if-exist, device/deepcomputing/kx/common/kx_system_ext.mk)

# Riscv patch for system: check later - XC-TODO
$(call inherit-product, device/deepcomputing/kx/common/system_riscv_patch.mk)

# AOSP default vendor configs
$(call inherit-product, device/deepcomputing/kx/common/aosp_vendor.mk)

# Extra packages
$(call inherit-product, device/deepcomputing/kx/common/kx-common.mk)

# k1 special vendor packages
$(call inherit-product, device/deepcomputing/kx/dp_k1/device-dp_k1.mk)

PRODUCT_MANUFACTURER := deepcomputing
PRODUCT_BRAND := Android
PRODUCT_NAME := dp_k1
PRODUCT_DEVICE := dp_k1
PRODUCT_MODEL := AOSP on DP_K1

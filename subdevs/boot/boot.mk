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

TARGET_NO_RECOVERY := true

PRODUCT_PACKAGES += \
	android.hardware.dumpstate@1.1-service.example \
# android.hardware.dumpstate@1.1-service.k1


# fastbootd
# PRODUCT_PACKAGES += \
    fastbootd \


# Reboot escrow
# PRODUCT_PACKAGES += \
    android.hardware.rebootescrow-service.default


#PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-service \
    android.hardware.boot@1.2-impl \


#android.hardware.boot@1.2-impl.recovery \

#PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false

# Enable userspace reboot
#$(call inherit-product, $(SRC_TARGET_DIR)/product/userspace_reboot.mk)

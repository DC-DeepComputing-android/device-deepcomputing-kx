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

PRODUCT_SYSTEM_PROPERTIES += \
    ro.telephony.default_network=9

PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.usejit=false \
	dalvik.vm.dex2oat-filter=interpret-only \
    \
    persist.sys.timezone = "Asia/Shanghai" \
    persist.sys.strictmode.disable=true \
	\
    ro.hardware.gralloc=minigbm \
    ro.hardware.hwcomposer=drm_minigbm \
    \
    debug.ui.default_mapper=4 \
    debug.ui.default_gralloc=4 \

	#dalvik.vm.image-dex2oat-filter=extract \
    #ro.sf.lcd_density=320
	#ro.hardware.egl=mesa
	#debug.drm.mode.force=640x480

#PRODUCT_PROPERTY_OVERRIDES += \
    ro.hw_timeout_multiplier=16 \
    debug.drm.mode.force=640x480 \
    gralloc.drm.kms=/dev/dri/card0 \
    ro.opengles.version=131072 \
    ro.hardware.egl=mesa \
    ro.hdmi.device_type=4

# Display lcd denstity(TODO)
TARGET_SCREEN_DENSITY := 280

# Reduces GC frequency of foreground apps by 50%
PRODUCT_PROPERTY_OVERRIDES += dalvik.vm.foreground-heap-growth-multiplier=2.0


# Set system properties identifying the chipset
PRODUCT_VENDOR_PROPERTIES += ro.soc.manufacturer=andes
PRODUCT_VENDOR_PROPERTIES += ro.soc.model=andes


# Fix cts bug CtsThemeHostTestCases about xhdpi assets missing
PRODUCT_AAPT_PREF_CONFIG := xhdpi

# Enable DM file pre-opting to reduce first boot time
#PRODUCT_DEX_PREOPT_GENERATE_DM_FILES :=true
#PRODUCT_DEX_PREOPT_DEFAULT_COMPILER_FILTER := verify


PRODUCT_PRODUCT_PROPERTIES += \
    ro.product.andes.version=RV64.Android.$(PLATFORM_VERSION_LAST_STABLE).alpha.V0.1


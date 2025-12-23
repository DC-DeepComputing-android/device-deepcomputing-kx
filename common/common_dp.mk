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


## Control Vars for ALL DP Devices
LOCAL_DP_DIR := device/deepcomputing/kx

## Always use Dynamic partition
PRODUCT_USE_DYNAMIC_PARTITIONS := true

PRODUCT_SYSTEM_PROPERTIES += \
    config.disable_renderscript=1 \

# Disable lock screen
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    ro.lockscreen.disable.default=1

# Default: CN or EN
# PRODUCT_LOCALES := zh_CN


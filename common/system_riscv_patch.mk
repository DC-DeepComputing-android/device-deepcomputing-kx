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

# FIXME(XC-TODO)  libcompiler_rt cannot be installed automotically, because there is no
# renderscript in riscv android platform
PRODUCT_PACKAGES += libcompiler_rt

ALLOW_MISSING_DEPENDENCIES := true
BUILD_BROKEN_MISSING_REQUIRED_MODULES := true

TARGET_SUPPORTS_OMX_SERVICE := false
PRODUCT_USES_DEFAULT_ART_CONFIG := false

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    root/init.zygote64.rc

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/lib64/libcompiler_rt.so \
    system/app/PlatformCaptivePortalLogin/% \
    system/priv-app/InProcessNetworkStack/% \
    system/priv-app/PlatformNetworkPermissionConfig/% \
    system/apex/com.android.tethering.inprocess.capex \
    system/priv-app/CellBroadcastServiceModulePlatform/% \


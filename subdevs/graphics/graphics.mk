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

# Graphics HAL
BOARD_MESA3D_USES_MESON_BUILD := true
#BOARD_GPU_DRIVERS := swrast virgl radeonsi
#BOARD_MESA3D_GALLIUM_DRIVERS := swrast virgl radeonsi
#PRODUCT_SOONG_NAMESPACES += external/mesa
BOARD_GPU_DRIVERS := swrast virgl radeonsi
BOARD_MESA3D_GALLIUM_DRIVERS := swrast virgl radeonsi
#BOARD_MESA3D_BUILD_LIBGBM := true

PRODUCT_SOONG_NAMESPACES += external/mesa

PRODUCT_PACKAGES += \
    hwcomposer.drm \
    hwcomposer.drm_minigbm \
    gralloc.minigbm_dmabuf \
    gralloc.minigbm \
    gralloc.gbm \
    libGLES_mesa \
    libglapi \
    libgallium_dri \
    amdgpu.ids \
    libOpenglSystemCommon \
    vndservicemanager \
    vndservice

#    hwcomposer.drm_celadon \
#    hwcomposer.drm_minigbm_celadon \
#    hwcomposer.drm_gbm_cros \
#    hwcomposer.drm_gbm_cros_celadon \
#    gralloc.minigbm_arcvm \
#    gralloc.minigbm_gbm_mesa \
#    gralloc.gbm_hack \
#    gralloc.gbm_noscanout \

PRODUCT_PACKAGES += \
    android.hardware.graphics.mapper@4.0-impl.minigbm \
    android.hardware.graphics.allocator@2.0-impl \
    android.hardware.graphics.allocator@4.0-service.minigbm \
    android.hardware.graphics.composer@2.1-impl \
    android.hardware.graphics.composer@2.1-service \
    android.hardware.configstore@1.1-service \

#PRODUCT_COPY_FILES += \
    device/generic/goldfish/display_settings_freeform.xml:$(TARGET_COPY_OUT_VENDOR)/etc/display_settings_freeform.xml \
	device/generic/goldfish/display_settings.xml:$(TARGET_COPY_OUT_VENDOR)/etc/display_settings.xml \


# graphics hal
#PRODUCT_PACKAGES += \
#    libEGL_mesa \
#    libGLESv1_CM_mesa \
#    libGLESv2_mesa \

#   memtrack \

PRODUCT_VENDOR_PROPERTIES += \
    ro.hardware.egl = mesa \

PRODUCT_COPY_FILES += $(call copy-files,$(wildcard  device/deepcomputing/k1-kernel/andes-qilai/amdgpu/*),$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/firmware/amdgpu)

#
# Copyright (C) 2019 The Android Open Source Project
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

include device/deepcomputing/kx/common/BoardConfigCommon.mk

TARGET_BOARD_PLATFORM := dp_k1_mesa
TARGET_BOOTLOADER_BOARD_NAME := vsoc_riscv64
BOARD_BOOTCONFIG += androidboot.hardware=k1

BOARD_KERNEL_CMDLINE += printk.devkmsg=on
BOARD_KERNEL_CMDLINE += firmware_class.path=/vendor/lib/firmware

BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_VENDOR_PROPERTY_NAMESPACE := true

#BOARD_SYSTEMIMAGE_PARTITION_SIZE := 912261120 #1073741824 #1024MB
BOARD_FLASH_BLOCK_SIZE := 512


# vendor_boot.img
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 0x02000000

#AB, no retrofit
BOARD_BUILD_SUPER_IMAGE_BY_DEFAULT := true
BOARD_SUPER_PARTITION_SIZE := 4294967296 # 4GB
BOARD_SUPER_PARTITION_GROUPS := k1_dynamic_partitions
BOARD_K1_DYNAMIC_PARTITIONS_PARTITION_LIST := system vendor system_ext product
BOARD_K1_DYNAMIC_PARTITIONS_SIZE := 2143289344 # 4GB/2 - 4M
BOARD_SUPER_PARTITION_METADATA_DEVICE := super
BOARD_SUPER_IMAGE_IN_UPDATE_PACKAGE := true

#Vendor partition definition
TARGET_COPY_OUT_VENDOR := vendor
#BOARD_VENDORIMAGE_PARTITION_SIZE := 146800640 #1073741824  #1024MB
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_JOURNAL_SIZE := 0
BOARD_VENDORIMAGE_EXTFS_INODE_COUNT := 2048

#Userdata partition definition
BOARD_USES_METADATA_PARTITION := true
#use "mmc part" to get userdata partition size in uboot console
#0x0087c000      0x01d1efde      "userdata"
#use "mmc info" to get block size
#(0x01d1efde-0x0087c000+1)*512 = 11079237120
BOARD_USERDATAIMAGE_PARTITION_SIZE := 2147483648  ##11079237120
TARGET_USERIMAGES_USE_F2FS := true
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs

#Cache partition definition
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456

#43M
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x2B00000

#8M
BOARD_INIT_BOOT_IMAGE_PARTITION_SIZE := 8388608

#64M
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 67108864

#Recovery
TARGET_RECOVERY_FSTAB := device/deepcomputing/kx/dp_k1/fstab.k1
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888

# XC-TODO!!
BOARD_BOOT_HEADER_VERSION := 4
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_INIT_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_INIT_ARGS += --header_version $(BOARD_INIT_BOOT_HEADER_VERSION)

# AVB Feature
# Specify vbmeta  certification and algorithms
# Enable AVB
# Please refer: https://android.googlesource.com/platform/external/avb/+/master/README.md
BOARD_AVB_ENABLE := true
BOARD_AVB_ALGORITHM := SHA256_RSA2048
BOARD_AVB_KEY_PATH := device/deepcomputing/kx/keys/kx_private.pem
BOARD_AVB_ALGORITHM := SHA256_RSA2048

# Specifiy vbmeta_system certificate, algorithms and rollback
#BOARD_AVB_VBMETA_SYSTEM := system system_ext product
#BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := device/deepcomputing/kx/keys/kx_private.pem
#BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
#BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
#BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 1

# Enable chained boot images
BOARD_AVB_BOOT_KEY_PATH := device/deepcomputing/kx/keys/kx_private.pem
BOARD_AVB_BOOT_ALGORITHM := SHA256_RSA2048
BOARD_AVB_BOOT_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_BOOT_ROLLBACK_INDEX_LOCATION := 2

BOARD_AVB_INIT_BOOT_KEY_PATH := device/deepcomputing/kx/keys/kx_private.pem
BOARD_AVB_INIT_BOOT_ALGORITHM := SHA256_RSA2048
BOARD_AVB_INIT_BOOT_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_INIT_BOOT_ROLLBACK_INDEX_LOCATION := 3

#Configure jemalloc for low memory, and default to a single arena to minimizethe PSS consumed by jemalloc
# XC-TODO
#MALLOC_SVELTE :=true
#ENABLE_JEMALLOC_TCACHE :=true


BOARD_SEPOLICY_DIRS += device/deepcomputing/kx/sepolicy/vendor
#SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += device/deepcomputing/kx/sepolicy/system_ext/public
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/deepcomputing/kx/sepolicy/system_ext/private

BOARD_ROOT_EXTRA_SYMLINKS += /vendor/firmware:/lib/firmware

# product.img
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_PRODUCT := product

# system_ext.img
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_SYSTEM_EXT := system_ext

#vendor_ramdisk.img
BOARD_BUILD_VENDOR_RAMDISK_IMAGE := true


# MESA
# Graphics
BOARD_MESA3D_USES_MESON_BUILD := true
BOARD_MESA3D_GALLIUM_DRIVERS := swrast
BOARD_MESA3D_FORCE_SOFTPIPE := true

USE_OPENGL_RENDERER := true  ## XC-TODO: Not Used?
TARGET_USES_HWC2 := true
TARGET_SCREEN_DENSITY := 160  ## XC-TODO

# Build OpenGLES emulation guest and host libraries
#BUILD_EMULATOR_OPENGL := true

# Build and enable the OpenGL ES View renderer. When running on the emulator,
# the GLES renderer disables itself if host GL acceleration isn't available.
#USE_OPENGL_RENDERER := true


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


PRODUCT_PACKAGES += \
    android.hardware.wifi@1.0-service \
    mac80211_create_radios \
    createns \
    dhcpclient \
    execns \
    hostapd \
    hostapd_nohidl \
    wpa_supplicant \

PRODUCT_COPY_FILES += \
    device/generic/goldfish/init.ranchu-core.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.ranchu-core.sh \
    device/generic/goldfish/init.ranchu-net.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.ranchu-net.sh \
    device/generic/goldfish/wifi/wpa_supplicant.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant.conf \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.passpoint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.passpoint.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.ethernet.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.ethernet.xml \

    #device/generic/goldfish/wifi/simulated_hostapd.conf:$(TARGET_COPY_OUT_VENDOR)/etc/simulated_hostapd.conf \
    #     device/generic/goldfish/wifi/init.wifi.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.wifi.sh \


## XC-TODO!!!
# Ethernet
#PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.ethernet.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.ethernet.xml



#PRODUCT_PACKAGES += \
    hostapd \
    hostapd_cli \
    wpa_supplicant \
    wpa_cli \
    wpa_supplicant.conf \
    libwpa_client \
    wifilogd \
    hostapd.conf \
    libwifi-hal \

# WiFi HAL
PRODUCT_PACKAGES += \
    android.hardware.wifi@1.0-service \
    android.hardware.wifi.hostapd \
    android.hardware.wifi.supplicant \
    wificond

# Wi-Fi
#BOARD_VENDOR_KERNEL_MODULES += device/deepcomputing/k1-kernel/kernel-6.1/cfg80211.ko \
    device/deepcomputing/k1-kernel/kernel-6.1/8852be.ko


#PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.passpoint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.passpoint.xml \
    $(LOCAL_DP_DIR)/supplicant_overlay_config/wpa_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant_overlay.conf \
    $(LOCAL_DP_DIR)/supplicant_overlay_config/p2p_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/p2p_supplicant_overlay.conf \

#PRODUCT_PROPERTY_OVERRIDES += \
    wifi.interface=wlan0 \
    wifi.direct.interface=p2p0 \


# Wifi
## XC-TODO: set wifi chip
#BOARD_WIFI_VENDOR := realtek

ifeq ($(BOARD_WIFI_VENDOR), realtek1)
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_rtl
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_rtl
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_WLAN_DEVICE := realtek
endif
#WIFI_HIDL_UNIFIED_SUPPLICANT_SERVICE_RC_ENTRY := true


# XC-TODO: disable all 
# Bluetooth
# rtkbt
#BOARD_HAVE_BLUETOOTH_RTK := true
#$(call inherit-product, hardware/realtek/bt/rtkbt/rtkbt.mk)

#BOARD_VENDOR_KERNEL_MODULES += device/deepcomputing/k1-kernel/kernel-6.1/bluetooth.ko \
    device/deepcomputing/k1-kernel/kernel-6.1/btrtl.ko \
    device/deepcomputing/k1-kernel/kernel-6.1/rtk_btusb.ko

# use bt controller efuse mac
#PRODUCT_PRODUCT_PROPERTIES += \
    persist.vendor.rtkbt.bdaddr_path=none

# Bluetooth HAL
#PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.0-impl \
    android.hardware.bluetooth@1.0-service


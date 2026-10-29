#
# Copyright (C) 2026 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/miro

# Inherit from device.mk configuration
$(call inherit-product, $(DEVICE_PATH)/device.mk)

# Release name
PRODUCT_RELEASE_NAME := miro

## Device identifier
PRODUCT_DEVICE := miro
PRODUCT_NAME := twrp_miro
PRODUCT_BRAND := POCO
PRODUCT_MODEL := POCO F7 Ultra
PRODUCT_MANUFACTURER := Xiaomi

# Assert
TARGET_OTA_ASSERT_DEVICE := miro

# Theme
AERA_STATUS_ICONS_ALIGN := center

# Strongbox Device Decryption
AERA_INCLUDE_OMAPI := true

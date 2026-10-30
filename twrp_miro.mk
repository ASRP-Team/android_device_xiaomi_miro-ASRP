#
# Copyright (C) 2026 AERA Recovery Project contributors
# Device: Xiaomi miro (POCO F7 Ultra)
# Branch: ASRP 16.0
# SoC   : Snapdragon 8 Elite (SM8750 / sun)
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/miro

# ─── Inheritance ──────────────────────────────────────────────────────────────
# Configure base.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# Configure core_64_bit_only.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)

# Configure virtual_ab compression.mk (stock ROM uses virtual A/B with XOR)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/compression_with_xor.mk)

# Configure emulated_storage.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Configure twrp common.mk
$(call inherit-product, vendor/twrp/config/common.mk)

# Configure full_base_telephony.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Device hardware configuration
$(call inherit-product, $(DEVICE_PATH)/device.mk)

# AERA-specific recovery configuration
$(call inherit-product, $(DEVICE_PATH)/aera_miro.mk)

# ─── Device identifier ────────────────────────────────────────────────────────
PRODUCT_RELEASE_NAME := miro
PRODUCT_DEVICE       := miro
PRODUCT_NAME         := twrp_miro
PRODUCT_BRAND        := POCO
PRODUCT_MODEL        := POCO F7 Ultra
PRODUCT_MANUFACTURER := Xiaomi

# Assert
TARGET_OTA_ASSERT_DEVICE := miro

# Match the stock ROM identity so AERA can detect the installed build.
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="miro-user 16 BP2A.250605.031.A2 OS3.1.260407.0.WOMCNXM release-keys"

BUILD_FINGERPRINT := POCO/miro_global/miro:16/BP2A.250605.031.A2/OS3.1.260407.0.WOMCNXM:user/release-keys

# Theme
AERA_STATUS_ICONS_ALIGN := center

# Strongbox Device Decryption
AERA_INCLUDE_OMAPI := true

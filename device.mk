#
# Copyright (C) 2026 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/miro

# Base product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)

# Virtual A/B OTA configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/compression_with_xor.mk)

# Emulated storage support
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Configure twrp common.mk
$(call inherit-product, vendor/twrp/config/common.mk)

# Device-specific AERA configuration
$(call inherit-product, $(DEVICE_PATH)/aera_miro.mk)

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-service \
    bootctrl.xiaomi_sm8750

PRODUCT_STATIC_BOOT_CONTROL_HAL := \
    bootctrl.xiaomi_sm8750 \
    libgptutils \
    libz \
    libcutils

PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload

# API
PRODUCT_SHIPPING_API_LEVEL := 35
PRODUCT_TARGET_VNDK_VERSION := 35
BOARD_SHIPPING_API_LEVEL := 35
SHIPPING_API_LEVEL := 35

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Adreno 830 userspace backend
PRODUCT_VENDOR_PROPERTIES += \
    ro.hardware.egl=adreno

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += $(DEVICE_PATH)

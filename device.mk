#
# Copyright (C) 2026 AERA Recovery Project contributors
# Device: Xiaomi miro (POCO F7 Ultra)
# Branch: ASRP 16.0
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/miro

# Shipping API level (device shipped with Android 15 / API 35)
BOARD_SHIPPING_API_LEVEL := 35
PRODUCT_SHIPPING_API_LEVEL := 35
PRODUCT_TARGET_VNDK_VERSION := 35
# The device uses 4 KiB pages, so disable the 16 KiB prebuilt alignment check.
PRODUCT_CHECK_PREBUILT_MAX_PAGE_SIZE := false

# ─── Dynamic partitions ───────────────────────────────────────────────────────
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_VIRTUAL_AB_OTA         := true

# ─── Fuse passthrough ─────────────────────────────────────────────────────────
PRODUCT_PROPERTY_OVERRIDES += persist.sys.fuse.passthrough.enable=true

# ─── Soong namespaces ─────────────────────────────────────────────────────────
PRODUCT_SOONG_NAMESPACES += $(DEVICE_PATH)

# ─── lptools ──────────────────────────────────────────────────────────────────
PRODUCT_PACKAGES += \
    lpmake \
    lpunpack

# ─── Audio (plugin-safe AGM bridge used by the media browser) ────────────────
PRODUCT_PACKAGES += \
    aera-audio-bridge \
    aera-audio-service

#
# Copyright (C) 2026 AERA Recovery Project contributors
# Device : Xiaomi miro (POCO F7 Ultra)
# SoC    : Snapdragon 8 Elite (SM8750 / sun)
# Branch : ASRP 16.0
#
# Confirmed from:
#   fastboot getvar all / lpdump super.img  (partition sizes, slots, logical flags)
#   vendor_boot fstab.qcom                   (FBEv2 + metadata encryption)
#   vendor_dlkm modules.load                 (dependency-ordered module list)
#   adb shell getprop + /sys/class/backlight (panel, brightness, density)
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/miro

# ─── Build rules ──────────────────────────────────────────────────────────────
ALLOW_MISSING_DEPENDENCIES := true
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_PLUGIN_VALIDATION := soong-libaosprecovery_defaults soong-libguitwrp_defaults soong-libminuitwrp_defaults soong-vold_defaults

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := kryo300

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := kryo300

TARGET_SUPPORTS_64_BIT_APPS := true
TARGET_SUPPORTS_32_BIT_APPS := true

# Power
ENABLE_CPUSETS := true
ENABLE_SCHEDBOOST := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := sun
TARGET_NO_BOOTLOADER := true
TARGET_USES_UEFI := true

# Platform
PRODUCT_PLATFORM := sun
TARGET_BOARD_PLATFORM := xiaomi_sm8750
TARGET_BOARD_PLATFORM_GPU := qcom-adreno830
TARGET_USES_VULKAN := true
QCOM_BOARD_PLATFORMS += xiaomi_sm8750

# Kernel
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_KERNEL_PAGESIZE := 4096
BOARD_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
BOARD_RAMDISK_USE_LZ4 := true
BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := true

# A/B — dedicated recovery partition (recovery_a/b, 100 MiB, raw)
BOARD_USES_RECOVERY_AS_BOOT := false
BOARD_RECOVERY_NEEDS_BOOTLOADER_CONTROL := true

AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    boot \
    init_boot \
    vendor_boot \
    dtbo \
    vbmeta \
    vbmeta_system \
    system \
    system_ext \
    product \
    vendor \
    vendor_dlkm \
    system_dlkm \
    odm

# Vendor boot
BOARD_USES_VENDOR_BOOTIMAGE := true
BOARD_BUILD_VENDOR_BOOT_IMAGE := false
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := false
BOARD_INCLUDE_RECOVERY_RAMDISK_IN_VENDOR_BOOT := false

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_INIT_BOOT_IMAGE_PARTITION_SIZE := 8388608
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 104857600
BOARD_DTBOIMG_PARTITION_SIZE := 25165824

BOARD_SUPER_PARTITION_SIZE := 11811160064
BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 11800674304
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    system \
    system_ext \
    product \
    vendor \
    vendor_dlkm \
    odm \
    system_dlkm

BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs

# EROFS for all logical partitions (confirmed from the stock recovery.fstab)
BOARD_PARTITION_LIST := $(call to-upper, $(BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST))
$(foreach p, $(BOARD_PARTITION_LIST), $(eval BOARD_$(p)IMAGE_FILE_SYSTEM_TYPE := erofs))
$(foreach p, $(BOARD_PARTITION_LIST), $(eval TARGET_COPY_OUT_$(p) := $(call to-lower,$(p))))
TARGET_COPY_OUT_VENDOR := vendor

# File systems
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_USES_VENDOR_DLKMIMAGE := true

# Recovery
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery.fstab
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TARGET_USES_MKE2FS := true

# Crypto
FIXED_DECRYPT := true
AERA_INCLUDE_CRYPTO := $(FIXED_DECRYPT)
AERA_INCLUDE_CRYPTO_FBE := $(FIXED_DECRYPT)
AERA_INCLUDE_FBE_METADATA_DECRYPT := $(FIXED_DECRYPT)
BOARD_USES_QCOM_FBE_DECRYPTION := $(FIXED_DECRYPT)
AERA_USE_FSCRYPT_POLICY := 2
BOARD_USES_METADATA_PARTITION := true
AERA_DEFAULT_KEYMASTER_VERSION := 4.0

# Security patch / anti-rollback
PLATFORM_VERSION := 99.87.36
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)
PLATFORM_SECURITY_PATCH := 2127-12-31
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
BOOT_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 0
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 0

# Board
TARGET_BOARD_INFO_FILE := $(DEVICE_PATH)/board-info.txt
TARGET_SYSTEM_PROP := $(DEVICE_PATH)/system.prop

# Tools
AERA_INCLUDE_REPACKTOOLS := true
AERA_INCLUDE_RESETPROP := true
AERA_INCLUDE_LIBRESETPROP := true
AERA_INCLUDE_LPDUMP := true
AERA_INCLUDE_LPTOOLS := true

# Debug
TARGET_USES_LOGD := true
AERA_INCLUDE_LOGCAT := true

# Fastbootd
AERA_INCLUDE_FASTBOOTD := true

# Other AERA configurations
AERA_THEME := portrait_hdpi
AERA_FRAMERATE := 120
TARGET_SCREEN_WIDTH := 1440
TARGET_SCREEN_HEIGHT := 3200
AERA_EXCLUDE_DEFAULT_USB_INIT := true
AERA_INCLUDE_FUSE_NTFS := true
AERA_INCLUDE_FUSE_EXFAT := true
AERA_INCLUDE_NTFS_3G := false
AERA_USE_TOOLBOX := true
AERA_INPUT_BLACKLIST := "hbtp_vm"
AERA_LOAD_VENDOR_MODULES := panel_event_notifier.ko xiaomi_touch.ko gh_irq_lend.ko gh_mem_notifier.ko focaltech_touch.ko mca_sysfs.ko mca_event.ko mca_log.ko mca_qcom_panel.ko qmi_helpers.ko wlan_firmware_service.ko cnss_plat_ipc_qmi_svc.ko cnss_prealloc.ko smem-mailbox.ko cnss_utils.ko qcom_ramdump.ko pcie-pdc.ko qcom_smd.ko qcom_glink.ko qcom_glink_smem.ko rproc_qcom_common.ko pci-msm-drv.ko mhi.ko cnss2.ko cnss_nl.ko repeater.ko redriver.ko pdr_interface.ko qti_pmic_glink.ko ucsi_qti_glink.ko wcd_usbss_i2c.ko dwc3-msm.ko usb_f_gsi.ko rmnet_mem.ko qcom_va_minidump.ko gsim.ko ipam.ko cfg80211.ko qca_cld3_peach_v2.ko qti_battery_debug.ko spf_core_dlkm.ko gpr_dlkm.ko audio_pkt_dlkm.ko adsp_loader_dlkm.ko audio_prm_dlkm.ko swr_dlkm.ko swr_ctrl_dlkm.ko swr_dmic_dlkm.ko swr_haptics_dlkm.ko wcd_core_dlkm.ko wcd9xxx_dlkm.ko lpass_cdc_dlkm.ko lpass_cdc_rx_macro_dlkm.ko lpass_cdc_tx_macro_dlkm.ko lpass_cdc_va_macro_dlkm.ko lpass_cdc_wsa_macro_dlkm.ko lpass_cdc_wsa2_macro_dlkm.ko wcd938x_dlkm.ko wcd938x_slave_dlkm.ko wcd939x_dlkm.ko wcd939x_slave_dlkm.ko wcd9378_dlkm.ko wcd9378_slave_dlkm.ko lpass_bt_swr_dlkm.ko mca_adsp_glink.ko qcom_adsp_pd_protocol.ko snd-usb-audio-qmi.ko
AERA_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness"
AERA_MAX_BRIGHTNESS := 16383
AERA_EXTRA_LANGUAGES := true
AERA_DEFAULT_LANGUAGE := en
AERA_DEFAULT_BRIGHTNESS := 1600
AERA_NO_SCREEN_BLANK := true
AERA_EXCLUDE_APEX := true
AERA_HAS_EDL_MODE := true
AERA_NO_LEGACY_PROPS := true
AERA_USE_SERIALNO_PROPERTY_FOR_DEVICE_ID := true
AERA_DEVICE_VERSION := POCO_F7_Ultra

# Debug
TARGET_RECOVERY_DEVICE_MODULES += debuggerd strace
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/debuggerd
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/strace

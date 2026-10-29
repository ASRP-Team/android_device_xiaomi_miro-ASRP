#
# Copyright (C) 2026 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

# screen settings
AERA_MAINTAINER := ASRP Team
AERA_UI_ADAPTIVE_RESOLUTION := true
AERA_SCREEN_H := 3200
AERA_STATUS_H := 150
AERA_HIDE_NOTCH := 1
AERA_CLOCK_POS := 1
AERA_STATUS_INDENT_LEFT := 64
AERA_STATUS_INDENT_RIGHT := 56
AERA_ALLOW_DISABLE_NAVBAR := 0
AERA_USE_GREEN_LED := 0

# other stuff
AERA_QUICK_BACKUP_LIST := /boot;/data;
AERA_ENABLE_LPTOOLS := 1
AERA_NO_TREBLE_COMPATIBILITY_CHECK := 1
AERA_DYNAMIC_FULL_SIZE := 9126805504

# number of list options before scrollbar creation
AERA_OPTIONS_LIST_NUM := 11

# A/B with recovery partition
AERA_AB_DEVICE_WITH_RECOVERY_PARTITION := 1

# ----- data format stuff -----
# ensure that /sdcard is bind-unmounted before f2fs data repair or format
AERA_UNBIND_SDCARD_F2FS := 1

# automatically wipe /metadata after data format
AERA_WIPE_METADATA_AFTER_DATAFORMAT := 1

# avoid MTP issues after data format
AERA_BIND_MOUNT_SDCARD_ON_FORMAT := 1

# Set to 1 to attempt to unmount the SD cards before rebooting
AERA_UNMOUNT_SDCARDS_BEFORE_REBOOT := 1

# don't spam the console with loop errors
AERA_LOOP_DEVICE_ERRORS_TO_LOG := 1

# lz4 compression
AERA_USE_LZ4_COMPRESSION := 1

# build all the partition tools
AERA_ENABLE_ALL_PARTITION_TOOLS := 1

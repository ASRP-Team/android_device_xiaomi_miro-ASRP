#
# Copyright (C) 2026 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

#set -o xtrace
FDEVICE="miro"

aera_get_target_device() {
	export script_path="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
	if echo "$script_path" | grep -q "$FDEVICE"; then
		AERA_BUILD_DEVICE="$FDEVICE"
	elif echo "$0" | grep -q "$FDEVICE"; then
		AERA_BUILD_DEVICE="$FDEVICE"
	fi
}

if [ -z "$AERA_BUILD_DEVICE" ]; then
	aera_get_target_device
fi

if [ "$AERA_BUILD_DEVICE" = "$FDEVICE" ]; then
	echo "Detected build device: $AERA_BUILD_DEVICE"

# AERA device build settings
	export AERA_BUILD_STATUS=Unofficial
	export AERA_BUILD_TYPE=Beta

	# A/B Partition
	export AERA_VIRTUAL_AB_DEVICE=1
	export AERA_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
	export AERA_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"

	# Compression Binaries & Tools
	export AERA_USE_BASH_SHELL=1
	export AERA_USE_NANO_EDITOR=1
	export AERA_USE_TAR_BINARY=1
	export AERA_USE_LZ4_BINARY=1
	export AERA_USE_SED_BINARY=1
	export AERA_USE_XZ_UTILS=1
	export AERA_USE_ZSTD_BINARY=1
	export AERA_DELETE_AROMAFM=1
	export AERA_REMOVE_AAPT=1
	export AERA_USE_BUSYBOX_BINARY=1
	export AERA_USE_GREP_BINARY=1

	# KernelSU / Magisk Support
	export AERA_DELETE_MAGISK_ADDON=1
	export AERA_MOVE_MAGISK_INSTALLER_TO_RAMDISK=1
	export AERA_ENABLE_ROOT_MANAGER=1

	# FBEv2 hardware decryption
	export OF_DEFAULT_KEYMASTER_VERSION=4.1

	# Build environment
	export ALLOW_MISSING_DEPENDENCIES=true
	export LC_ALL="C"
fi

# ASRP Recovery for Xiaomi miro

ASRP (AERA Recovery Project) 16.0 device tree for the POCO F7 Ultra (`miro`).
Every hardware value in this tree comes from the device itself or from a
partition dump, not from a guessed template.

## Device

- SoC: Snapdragon 8 Elite (SM8750 / `sun`)
- Display: 1440x3200, 120 Hz OLED, 600 dpi
- Backlight: `/sys/class/backlight/panel0-backlight`, max brightness 16383
- Kernel: prebuilt GKI 6.6.77 (4 KiB pages, GKI `android15-6.6`)
- Partition layout: Virtual A/B with dedicated slot-aware `recovery_a/b`
- Encryption: FBE v2 (`aes-256-xts:aes-256-cts:v2`, wrapped keys) plus
  metadata encryption
- KeyMint: QTI TEE (`android.hardware.security.keymint` v3) with
  `keymaster@4.0-service-qti`
- Touch: `focaltech_ts` (driver `focaltech_touch.ko`)
- Wi-Fi: `qca_cld3_peach_v2.ko`
- Recovery partition size: 100 MiB

## Layout

| Path | Purpose |
|---|---|
| `BoardConfig.mk` | All hardware and build configuration |
| `device.mk` | Product configuration only (API level, dynamic partitions, soong namespace, packages) |
| `aera_miro.mk` | AERA UI metrics and recovery behaviour switches |
| `twrp_miro.mk` | Product definition and inheritance chain |
| `AndroidProducts.mk` | Lunch target `twrp_miro-bp2a-eng` |
| `vendorsetup.sh` | AERA build environment (tools, root manager, A/B flags) |
| `recovery.fstab` | Mount table, taken from the stock vendor_boot `fstab.qcom` |
| `prebuilt/kernel` | Stock GKI kernel (36.4 MB) |
| `recovery/root/` | Vendor pieces copied into the recovery ramdisk |
| `audio/` | Plugin-safe AGM PCM bridge and service (recovery media playback) |
| `board-info.txt` | Build fingerprint requirements |
| `system.prop` | Recovery system properties |
| `Android.mk`, `Android.bp` | Soong namespace and legacy hooks |

## Data provenance

| Value | Source |
|---|---|
| Partition sizes, `super` group layout | `lpdump` on the stock `super` dump |
| Kernel, pagesize, header version | `boot_a.img` via `magiskboot unpack` |
| `fstab`, FBEv2 flags, metadata encryption | `vendor_boot.img` ramdisk `fstab.qcom` |
| `AERA_LOAD_VENDOR_MODULES` | `vendor_dlkm` `modules.load`, dependency ordered |
| KeyMint / keymaster version | `vendor/etc/vintf/manifest.xml` |
| Touch, panel, brightness | `dtbo.img` overlays, `adb shell getprop`, sysfs |
| Build fingerprint | Stock ROM `build.prop` (OS3.0.303.0.WOMCNXM base, OS3.1 branch) |

## Build

Place this tree at `device/xiaomi/miro` inside an ASRP 16.0 checkout, then:

```bash
source build/envsetup.sh
lunch twrp_miro bp2a eng
m -j4 recoveryimage
```

Output: `out/target/product/miro/recovery.img`.

Use `-j4` on a 16 GB host; Soong's first run is memory hungry.

## Flash

```bash
# dedicated recovery partition, slot aware
fastboot flash recovery recovery.img
fastboot reboot recovery
```

## Current status

Testing tree, not feature complete.

Working: build configuration, partition table, kernel, FBEv2/KeyMint
services, touch and panel module chain, Wi-Fi module chain, audio bridge
sources, A/B + dedicated recovery layout.

Known gaps:

- `recovery/root` does not yet carry the full vendor HAL library set that
  AERA ships for myron (display mapper, secureprocessor, vibrator, ODM
  services, `init.recovery.qcom.rc`, Wi-Fi firmware).
- No `security/releasekey.x509.pem`; the image is signed with AOSP test keys.
- No `transplanting_vbmeta.py`; stock vbmeta is replaced with the test key
  image.
- Wi-Fi and USB modules are still loaded together at boot instead of split
  into `AERA_POST_DECRYPT_MODULES`.
- `AERA_SCREEN_H` / `AERA_STATUS_H` are derived from AERA's 1080-wide
  reference space (2400 / 165) and have not been verified on hardware.

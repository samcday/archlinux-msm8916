#!/bin/bash
set -uexo pipefail

# This script prepares a boot.img from the locally built image, and boots it directly

kver=$(sudo mkosi shell ls /lib/modules)
sudo mkosi shell cat /lib/modules/${kver}/vmlinuz | gzip > /tmp/vmlinuz-dtb
sudo mkosi shell cat /lib/modules/${kver}/dtbs/qcom/msm8916-samsung-a5u-eur.dtb >> /tmp/vmlinuz-dtb
sudo mkosi shell cat /boot/initramfs > /tmp/initramfs

sudo mkbootimg \
    --kernel /tmp/vmlinuz-dtb \
    --ramdisk /tmp/initramfs \
    --base "0x80000000" \
    --second_offset "0x00f00000" \
    --cmdline "${EXTRA_CMDLINE:-}" \
    --kernel_offset "0x00080000" \
    --ramdisk_offset "0x02000000" \
    --tags_offset "0x01e00000" \
    --pagesize "2048" \
    -o /tmp/boot.img

fastboot boot /tmp/boot.img

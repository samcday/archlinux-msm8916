#!/bin/bash
set -uexo pipefail

# prepares a boot.img from the locally built image tree and boot it directly

cat image/boot/Image.gz image/boot/dtbs/qcom/msm8916-samsung-a5u-eur.dtb > /tmp/vmlinuz-dtb
sudo mkbootimg \
    --kernel /tmp/vmlinuz-dtb \
    --ramdisk image/boot/initramfs \
    --base "0x80000000" \
    --second_offset "0x00f00000" \
    --cmdline "console=tty0 root=UUID=8a0b09b9-2862-4937-b0cc-117a26c52961 systemd.firstboot=off ${EXTRA_CMDLINE:-}" \
    --kernel_offset "0x00080000" \
    --ramdisk_offset "0x02000000" \
    --tags_offset "0x01e00000" \
    --pagesize "2048" \
    -o /tmp/boot.img

fastboot boot /tmp/boot.img

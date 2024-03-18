#!/bin/bash
set -uexo pipefail

# prepares a boot.img from the locally built image tree and boot it directly

cat image/boot/Image.gz image/boot/dtbs/qcom/msm8916-samsung-a5u-eur.dtb > /tmp/vmlinuz-dtb
sudo mkbootimg \
    --kernel /tmp/vmlinuz-dtb \
    --ramdisk image/boot/initramfs \
    --base "0x80000000" \
    --second_offset "0x00f00000" \
    --cmdline "console=tty0 root=UUID=e8abdfd5-c87a-4fb9-8baa-d400f3f285e5 systemd.firstboot=off ${EXTRA_CMDLINE:-}" \
    --kernel_offset "0x00080000" \
    --ramdisk_offset "0x02000000" \
    --tags_offset "0x01e00000" \
    --pagesize "2048" \
    -o /tmp/boot.img

fastboot boot /tmp/boot.img

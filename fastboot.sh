#!/bin/bash
set -uexo pipefail

# prepares a boot.img from the locally built image tree and boot it directly

sudo mkbootimg \
    --kernel image/boot/vmlinuz-dtb \
    --ramdisk image/boot/initramfs-6.6.0-msm8916.img \
    --base "0x80000000" \
    --second_offset "0x00f00000" \
    --cmdline "earlycon rd.retry=15 rd.shell root=UUID=e8abdfd5-c87a-4fb9-8baa-d400f3f285e5" \
    --kernel_offset "0x00080000" \
    --ramdisk_offset "0x02000000" \
    --tags_offset "0x01e00000" \
    --pagesize "2048" \
    -o /tmp/boot.img

fastboot boot /tmp/boot.img

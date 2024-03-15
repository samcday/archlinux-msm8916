#!/bin/bash
set -uexo pipefail

dir=$(mktemp)
rm -rf $dir
mkdir -p $dir/{boot,root}

boot_dev=/dev/mapper/$(sudo kpartx -l image.raw | head -n1 | cut -d ' ' -f1)
root_dev=/dev/mapper/$(sudo kpartx -l image.raw | tail -n1 | cut -d ' ' -f1)

trap "set +x; sudo umount $boot_dev; sudo umount $root_dev; sudo kpartx -d image.raw" EXIT
sudo kpartx -afs image.raw

sudo mount $boot_dev $dir/boot
sudo mount $root_dev $dir/root

sudo cat $dir/root/usr/lib/modules/vmlinuz $dir/boot/dtbs/qcom/msm8916-samsung-a5u-eur.dtb > /tmp/vmlinuz-dtb
sudo mkbootimg \
    --kernel /tmp/vmlinuz-dtb \
    --ramdisk $dir/boot/initramfs-6.6.0-msm8916.img \
    --base "0x80000000" \
    --second_offset "0x00f00000" \
    --cmdline "earlycon rd.retry=30 rd.shell root=UUID=e01dcf94-b2d4-4c0d-901e-7e44d47f360c" \
    --kernel_offset "0x00080000" \
    --ramdisk_offset "0x02000000" \
    --tags_offset "0x01e00000" \
    --pagesize "2048" \
    -o /tmp/test.img
fastboot boot /tmp/test.img

#!/bin/sh

cat image/usr/lib/modules/vmlinuz image/boot/dtbs/qcom/msm8916-samsung-a5u-eur.dtb > /tmp/vmlinuz-dtb
sudo mkbootimg \
    --kernel /tmp/vmlinuz-dtb \
    --ramdisk image/boot/initramfs-6.6.0-msm8916.img \
    --base "0x80000000" \
    --second_offset "0x00f00000" \
    --cmdline "earlycon rd.break rd.retry=30 rd.shell rd.debug log_buf_len=1M" \
    --kernel_offset "0x00080000" \
    --ramdisk_offset "0x02000000" \
    --tags_offset "0x01e00000" \
    --pagesize "2048" \
    -o /tmp/test.img
fastboot boot /tmp/test.img

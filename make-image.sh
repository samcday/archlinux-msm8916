#!/bin/bash
set -uexo pipefail

dir=$(mktemp)
rm -rf $dir
mkdir -p $dir/{boot,root}

trap "set +x; sudo umount $dir/root; sudo umount $dir/boot; sudo kpartx -d image.disk" EXIT

truncate -s 1500M image.disk
parted -s image.disk mktable msdos mkpart primary ext2 2048s 256M mkpart primary 256M 100% set 1 boot on


boot_dev=/dev/mapper/$(sudo kpartx -l image.disk | head -n1 | cut -d ' ' -f1)
root_dev=/dev/mapper/$(sudo kpartx -l image.disk | tail -n1 | cut -d ' ' -f1)
sudo kpartx -afs image.disk

sudo mkfs.ext2 -U "82cf7dcc-2956-47aa-aecc-7a186a2fa7b0" $boot_dev
sudo mkfs.ext4 -U "e8abdfd5-c87a-4fb9-8baa-d400f3f285e5" $root_dev

sudo mount $boot_dev $dir/boot
sudo mount $root_dev $dir/root

sudo cp -aR image/boot/* $dir/boot
sudo cp -aR image/* $dir/root
sudo rm -rf $dir/root/boot/*

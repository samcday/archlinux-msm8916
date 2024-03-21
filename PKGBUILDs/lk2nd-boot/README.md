# lk2nd-boot

This package provides the support necessary to make Arch Linux bootable under [lk2nd](https://github.com/msm8916-mainline/lk2nd). lk2nd is inserted after the proprietary Qualcomm bootchain (it replaces aboot) to provide flexibility in booting non-Android OSes.

It does the following:

 * Generates `extlinux/extlinux.conf` + `boot.img` files which lk2nd uses to boot Linux.
 * Installs a mkinitcpio hook to discover the nested root + boot partitions inside the userdata partition.
 * Ensures the nested root partition is resized to fill 100% of available space.
 * Configures baseline kernel command-line to discover root partition and some other useful stuff (console output, enable splash)
 * Disables [systemd-firstboot](https://man.archlinux.org/man/systemd-firstboot.1)
 * Creates systemd mount+automount units for the `/boot` partition.

## What?

Currently, lk2nd is the only viable option for booting Linux on msm8916 devices. lk2nd expects the userdata to contain an MBR partition table, with a bootable ext2 partition.

For the current **stable** version of lk2nd, it is expected that this partition contains a standard Android `boot.img` file

For the [`-next`](https://github.com/msm8916-mainline/lk2nd/tree/rebase/next) version of lk2nd, it no longer supports this `boot.img` and instead expects an `extlinux/extlinux.conf` file to exist.

This package ensures that both files exist and point to the current kernel + initramfs.

It should be noted that this whole approach is viewed by this maintainer as "somewhat temporary". There are hopes that a proper UEFI/EBBR boot environment will be provided by the early bootloader. Either lk2nd will chain U-Boot, or U-Boot will get enough msm8916 support to replace lk2nd entirely.

As a result, this package should be deemed a temporary and necessary hack.

To keep it simple, the root and boot partitions are assumed to have fixed UUIDs:

`root` = `8a0b09b9-2862-4937-b0cc-117a26c52961`
`boot` = `cbb0d631-0355-4bef-b25c-b140f01cf9b4`

These UUIDs will be embedded into the kernel command line for early initrd, and in the `/boot` mount definition.

Because `mkinitcpio` already has support for `/etc/cmdline.d`, but *only* for UKIs, this package will embed all command-line parameters into the extlinux.conf file. The idea is for you to start using the "right" way of specifying kernel command-line parameters now, so there's less friction later when your msm8916 device is booting from a UKI.

## TL;DR

Think of this package as a "hacky" version of [`postmarketOS/boot-deploy`](https://gitlab.com/postmarketOS/boot-deploy). Instead of trying to properly formalize a legacy way of booting msm8916 devices, this package aims to do the absolute minimum necessary until a UEFI environment becomes available.

## Future vision

Once a proper UEFI environment exists, this package can be deprecated and eventually removed.

Instead, standard systemd-boot can be employed, and mkinitcpio can be permitted to generate a standard UKI. The initrd can boot from auto GPT discoverable partitions, A/B booting with systemd-bless-boot, and so on.

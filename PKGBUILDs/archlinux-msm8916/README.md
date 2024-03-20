# archlinux-msm8916

This package adds support for booting MSM8916 devices with [lk2nd](https://github.com/msm8916-mainline/lk2nd).

Specifically, it does the following:

 * Generates `extlinux/extlinux.conf` for lk2nd-next support.
 * Ensures rootfs can be found.
 * Configures mounting of `/boot`
 * Ensures [msm8916-generated panels](https://github.com/msm8916-mainline/linux-mdss-dsi-panel-driver-generator) and other important kernel modules are included in initramfs.

For now, until UEFI support exists, the filesystem UUIDs of the boot and root partitions are assumed to be fixed. They are specified in the generated images that are generated.

TODO:

 * Generate a `boot.img` Android boot file for the current kernel, initramfs, and booted device DTB.

The list of drivers to include in the initramfs can be determined by running the following in pmaports:

```
(for file in $(grep -El "soc-qcom-msm8916( |$)" **/device/{community,main}/device-*/APKBUILD); do
  name=$(basename $(dirname $file))
  deviceinfo=$(dirname $file)/deviceinfo
  source $deviceinfo

  [[ "$deviceinfo_arch" != "aarch64" ]] && continue
  cat $(dirname $file)/modules-initfs
done) | sort | uniq | xargs
```

# archlinux-msm8916

**Experimental, don't use this for anything yet.**

Boot Arch Linux ARM on your [MSM8916][1] devices.

## Usage

This repository is currently in the exploratory/experimentation phase. If you're brave, you can try and follow along.

Make sure you've [installed the lk2nd bootloader][5] first.

```
# Build the image
sudo mkosi

# Explore the image
sudo mkosi shell

# Prepare the image for flashing
./make-mbr-image.sh

# Flash the image to your device
fastboot flash userdata image.raw.mbr

# Cross your fingers. Hold on to yer butts.
fastboot reboot
```

Note: `lk2nd-next` will *not* work, as it has dropped `boot.img` support, and the new extlinux loading has limits on initramfs size. You can build and flash [my fork][7], but note that this has only been lightly tested specifically for samsung-a5 devices.

## Project scope

The goal of this project is to make Arch Linux ARM a viable option to boot on these devices, with as few changes from upstream as possible. As such there should only be a small set of packages maintained that bridge the gap between Arch Linux and the quirks and non-standard aspects of these devices. See the [`PKGBUILDs`](./PKGBUILDs/) directory for this list of packages.

## (Potentially) FAQ

### [postmarketOS][3] already has mature support for MSM8916 devices. Why bother with this?

pmOS has a much larger scope. It is trying to support a very wide range of devices, including many armv7 devices. Many of these devices have extremely modest resources and very demanding limits. It will never be feasible to run Arch Linux on such devices.

As a consequence of these requirements, postmarketOS has opted to "reinvent the wheel":

 * [mkinitfs](https://gitlab.com/postmarketOS/postmarketos-mkinitfs) instead of mkinitcpio/dracut/booster (or even Alpine upstream mkinitfs!)
 * [pbsplash](https://git.sr.ht/~calebccff/pbsplash/tree) instead of Plymouth.
 * [boot-deploy](https://gitlab.com/postmarketOS/boot-deploy) instead of UKIs.

As they diverge further and further from their Alpine upstream, they are also shouldering an increasing amount of packaging burden.

What this project aims to do is identify the absolute minimum amount of work required for MSM8916 devices to boot into a standard Arch environment. Besides the glue to boot, and (for now) the custom kernel with msm8916 support, your device will be running standard packages from upstream Arch.

### [Kupfer Linux][6] already exists. Why bother with this?

Kupfer has a specific goal of being [to Arch Linux what postmarketOS is to Alpine](https://kupfer.gitlab.io/#what-is-kupfer). That is, they aim to repurpose and repackage many of the same idioms and specific tools/packages from postmarketOS.

As noted earlier, it is this maintainer's opinion that this approach is ultimately flawed, as it is diverging further and further from the current state of the art in most other distros.

[1]: https://wiki.postmarketos.org/wiki/Qualcomm_Snapdragon_410/412_(MSM8916)#Devices
[2]: https://github.com/systemd/mkosi
[3]: https://postmarketos.org/
[4]: https://github.com/msm8916-mainline/lk2nd#lk2nd
[5]: https://github.com/msm8916-mainline/lk2nd#installation
[6]: https://kupfer.gitlab.io/
[7]: https://github.com/samcday/lk2nd

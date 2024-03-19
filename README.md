# archlinux-msm8916

**Experimental, don't use this for anything yet.**

Boot Arch Linux ARM on your [MSM8916](https://wiki.postmarketos.org/wiki/Qualcomm_Snapdragon_410/412_(MSM8916)#Devices) devices.

## Usage

This repository is currently in the exploratory/experimentation phase. If you're brave, you can try and follow along.

Make sure you've [installed the lk2nd bootloader][5] first.

```
# Build the image
sudo mkosi

# Explore the image
sudo mkosi shell

# Prepare the image for flashing
./make-image.sh

# Flash the image to your device
fastboot flash userdata image.disk

# Cross your fingers. Hold on to yer butts.
fastboot reboot
```

Note: `lk2nd-next` will *not* work, as it has dropped `boot.img` support, and the new extlinux loading has limits on initramfs size. You can build and flash [my fork][7], but note that this has only been lightly tested specifically for samsung-a5 devices.

## Project scope

The goal of this project is to make Arch Linux ARM a viable option to boot on these devices, with as few changes from upstream as possible. As such there should only be a small set of packages maintained that bridge the gap between Arch Linux and the quirks and non-standard aspects of these devices. See the [`PKGBUILDs`](./PKGBUILDs/) directory for this list of packages.

## (Potentially) FAQ

### [postmarketOS][3] already has mature support for the A5. Why bother with this?

Good question, and well asked.

### [Kupfer Linux][6] already exists. Why bother with this?

Good question, and well asked.

### What can pmOS do that this can't?

Everything, basically.

### What can this do that pmOS can't?

 * `journalctl` with full logs from the earliest part of kernel boot and the entire init process.
 * glibc

[1]: https://wiki.postmarketos.org/wiki/Samsung_Galaxy_A5_2015_(samsung-a5)
[2]: https://github.com/systemd/mkosi
[3]: https://postmarketos.org/
[4]: https://github.com/msm8916-mainline/lk2nd#lk2nd
[5]: https://github.com/msm8916-mainline/lk2nd#installation
[6]: https://kupfer.gitlab.io/
[7]: https://github.com/samcday/lk2nd

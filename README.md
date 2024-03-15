# samsung-a5-alarm

This repository demonstrates how to boot Arch Linux ARM (ALARM) on a [Samsung Galaxy A5][1] phone.

It uses [mkosi][2] to build an image that is suitable for flashing to an A5 device.

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

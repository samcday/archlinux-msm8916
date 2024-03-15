# samsung-a5-alarm

This repository will (eventually) demonstrate how to boot Arch Linux ARM (ALARM) on a [Samsung Galaxy A5][1] phone.

It uses [mkosi][2] to build an image that ~~is~~ will be suitable for flashing to an A5 device.

## Usage

This repository is currently in the exploratory/experimentation phase. If you're brave, you can try and follow along.

First, you need to build the image:

```
sudo mkosi
```

Then, you need to reboot your A5 into [lk2nd][4] (you've [installed lk2nd to your A5, right?][5]) fastboot mode (hold volume-down while powering up the device). Then, run this to test booting the kernel + initramfs:

```
./fastboot.sh
```

## Why?

You might be asking, "[postmarketOS][3] already has mature support for the A5. So why bother with this project?"

Good question, and well asked.

[1]: https://wiki.postmarketos.org/wiki/Samsung_Galaxy_A5_2015_(samsung-a5)
[2]: https://github.com/systemd/mkosi
[3]: https://postmarketos.org/
[4]: https://github.com/msm8916-mainline/lk2nd#lk2nd
[5]: https://github.com/msm8916-mainline/lk2nd#installation

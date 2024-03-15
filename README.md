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

## (Potentially) FAQ

### [postmarketOS][3] already has mature support for the A5. Why bother with this?

Good question, and well asked.

### [Kupfer Linux][6] already exists. Why bother with this?

(what follows should probably be a properly thought-out and writtne essay that lives somewhere else but here)

I tried Kupfer. I think it's the wrong approach for a few reasons.

First of all, it's very rough right now. It's supposed to be an Arch Linux ARM distribution for phones, and yet the basic installation of their tooling doesn't properly work on Arch Linux. The mainline "stable" branch of `kupferbootstrap` hasn't had any commits in nearly 2 years. The `dev` branch breaks on basic invocations.

Kupfer is trying to be like postmarketOS, and in doing so is propagating/repeating the same approach, which I think is flawed. The idea with this project and approach is to minimize reinventing the wheel. PostmarketOS has:

 * Very limited and bespoke initrd generation tooling, instead of using Dracut or mkinitcpio, or, hell, mkinitfs from their upstream Alpine.
 * Custom build environment tooling (instead of using mature and featureful tools like `systemd-nspawn`, `mkosi`, and such)
 * A custom splash, instead of using Plymouth.

There's lots of good reasons, and lots of bad reasons, for why it is this way:

 * pmOS is trying to support a massive range of devices. Everything from potato Chromebooks/feature phones manufactured 10 years ago, to the Steam Deck.
 * pmOS is a scrappy community effort that is still in the infancy stage when compared to established distros like Arch, Debian, Fedora, etc.

Much of the work that contributors are doing behind the scenes for pmOS is incredible stuff. Without their work, we'd still only be able to install a solid mainline Linux distribution on like, 5 different devices (the Librem, the Pine64 phones and ... well, that's it?).

I guess I would summarize this rant thusly: postmarketOS is lots of different efforts. Some of it is extremely valuable, some of it is not and is reinventing the wheel poorly.

I would say the valuable aspects of postmarketOS are:

 * Mainlining efforts. That is getting drivers for countless mobile devices out of GPL code dumps from ~~awful soulless commercial vampires vendors~~ like Samsung/Qualcomm/etc and into the mainline Linux kernel.
 * Bootloader efforts. Making it possible to transitiong from janky vendor code that was only intended to boot into whatever crappy OS they were shoving down their customers throats.
 * Research efforts: continuing to lift the veil on the technical particulars of the myriad Android devices that were yeeted into the market over the last decade or so.

Beyond that, though, I think that most of their user-land (i.e basically everything they're doing from the moment the kernel hands over to initramfs) efforts are in vain. They're reinventing the wheel far too much.

[1]: https://wiki.postmarketos.org/wiki/Samsung_Galaxy_A5_2015_(samsung-a5)
[2]: https://github.com/systemd/mkosi
[3]: https://postmarketos.org/
[4]: https://github.com/msm8916-mainline/lk2nd#lk2nd
[5]: https://github.com/msm8916-mainline/lk2nd#installation
[6]: https://kupfer.gitlab.io/

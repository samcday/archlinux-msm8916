The msm8916 modem has incomplete support.

As of now:

 * SMS can be sent and received, however note that a bug in ModemManager means that you'll receive short text messages twice (#23)
 * Phone calls are not yet supported (#21)
 * Data has not been tested, it's suggested in postmarketOS wiki that 4G is not supported.

## Installation

The `ModemManager` and `rmtfs` packages are required.

```
pacman -Syu modemmanager rmtfs
```

Once installed, you must enable both of these services:

```
systemctl enable --now rmtfs
systemctl enable --now ModemManager
```

The [Chatty](https://gitlab.gnome.org/World/Chatty#chatty) GNOME UI application is available for sending and receiving SMS:

```
pacman -Syu gnome-chatty
```

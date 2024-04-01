[Plymouth](https://wiki.archlinux.org/title/Plymouth) works great on msm8916 devices. Simply follow the Arch wiki for installation and configuration.

## Toggling between splash/details

On computers with a keyboard, Plymouth supports toggling between the graphical splash screen and displaying the console output of the Linux boot process. This can also be achieved on a device with physical buttons, with some extra effort.

To accomplish this, you must use `vconsole.conf` to remap a keycode to the "Escape" key.

First, decide which button you want to perform this action. Then, use the `showkey` command to determine the keycode of this button.

Here's an example showing that the Home button (the bottom middle button) of a Samsung Galaxy A5 is keycode 172:

```
$ showkey
press any key (program terminates 10s after last keypress)...
keycode 172 press
keycode 172 release
```

Next, create a keymap file to perform this remapping:

```
cat > /usr/share/kbd/keymaps/phone-button-as-escape.map <<HERE
keycode 172 = Escape
HERE
```

Next, ensure this file is included in your initramfs (assuming that you're using mkinitcpio):

```
cat > /etc/mkinitcpio.conf.d/phone-button-as-escape.conf <<HERE
FILES+=(/usr/share/kbd/keymaps/phone-button-as-escape.map)
HERE
```

Finally, update your kernel command line to instruct Plymouth to use this keymap file:

```
echo -n 'rd.vconsole.keymap=phone-button-as-escape ' >> /etc/kernel/cmdline 
```

Ensure your initramfs is rebuilt:

```
kernel-install add
```

## Further reading

* https://wiki.archlinux.org/title/Linux_console/Keyboard_configuration#Creating_a_custom_keymap

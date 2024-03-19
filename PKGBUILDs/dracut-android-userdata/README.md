# dracut-android-userdata

This dracut hook facilitates mounting a nested partition table inside the Android userdata partition. This is useful for booting Linux distributions like postmarketOS on an Android device.

This hook waits for a partition with the label `userdata` to appear (via a udev rule). When such a partition is discovered, and confirmed to contain a nested (GPT or MBR) partition table, the hook will do two things:

 * Resize the last partition to fill 100% of remaining space.
 * Map the nested partitions with `kpartx`.

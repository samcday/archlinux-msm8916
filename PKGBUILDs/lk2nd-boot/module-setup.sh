check() {
    return 0
}

install() {
    inst bash
    inst kpartx
    inst parted
    inst jq

    inst "${moddir}/cmdline.conf" /etc/cmdline.d/lk2nd-boot.conf
    inst "${moddir}/mount-userdata.sh" /usr/bin/mount-userdata.sh
    inst_rules "${moddir}/userdata-partition.rules"
}

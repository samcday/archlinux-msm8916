check() {
    return 0
}

install() {
    inst_multiple \
        bash \
        ip \
        head \
        dnsmasq \
        /usr/share/dnsmasq/usb-network.conf \
        /usr/bin/usb-network-start \
        /usr/bin/usb-network-stop \
        "${systemdsystemunitdir}/usb-network.service" \
        "${systemdsystemunitdir}/usb-gadget.target"

    $SYSTEMCTL -q --root "$initdir" enable usb-network.service
}

installkernel() {
    instmods libcomposite usb_f_ncm
}

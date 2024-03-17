check() {
    return 0
}

install() {
    inst_multiple -o \
        "/usr/bin/start-usb-gadget.sh" \
        "${systemdsystemunitdir}/usb-network-gadget.service" \
        "${systemdsystemunitdir}/usb-gadget.target"
    
    $SYSTEMCTL -q --root "$initdir" enable usb-network-gadget.service
}

installkernel() {
    instmods libcomposite usb_f_ncm
}

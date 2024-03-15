#!/bin/bash
set -uexo pipefail

mkdir usb-network
cd usb-network

echo "0x04e8" > idVendor
echo "0x6860" > idProduct

mkdir strings/0x409
(
    cd strings/0x409
    echo "Samsung" > manufacturer
    echo "Samsung Galaxy A5 (2015)" > product
)

mkdir functions/ncm.usb0

mkdir configs/c.1
mkdir configs/c.1/strings/0x409
echo "USB network" > configs/c.1/strings/0x409/configuration

ln -s $(pwd)/functions/ncm.usb0 configs/c.1/

udc=$(ls -1 /sys/class/udc | head -n1)
echo $udc > UDC

ip link set usb0 up
ip addr add 172.16.42.1/24 dev usb0

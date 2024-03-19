#!/bin/bash
set -uexo pipefail

pacman --noconfirm --noprogressbar -Sy sudo

useradd builder -m
echo 'builder ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers

BUILDDIR=${GITHUB_WORKSPACE}/_build
PKGDEST=${GITHUB_WORKSPACE}/_pkg
SRCDEST=${GITHUB_WORKSPACE}/_src

mkdir $BUILDDIR $PKGDEST $SRCDEST
chown builder:builder $BUILDDIR $PKGDEST $SRCDEST

cd $1
sudo -u builder \
    BUILDDIR="$BUILDDIR" \
    PKGDEST="$PKGDEST" \
    SRCDEST="$SRCDEST" \
    CARCH="${CARCH:-}" \
    makepkg --noconfirm -s

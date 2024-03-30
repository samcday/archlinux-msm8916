#!/bin/bash
set -uexo pipefail

cat >> /etc/pacman.conf <<HERE
[msm8916]
Server = https://archlinux-msm8916.samcday.com
SigLevel = Never
HERE

pacman --noprogressbar --noconfirm -Sy sudo

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
    CARCH="${CARCH:-aarch64}" \
    makepkg --noprogressbar --noconfirm -s

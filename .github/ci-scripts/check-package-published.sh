#!/bin/bash
set -uexo pipefail

# This script will parse the .SRCINFO of a package, and check if it's already in the msm8916 repo.
# Exits with 1 if exists, 0 otherwise.

repo="https://archlinux-msm8916.samcday.com"

srcinfo="$1/.SRCINFO"
pkgver=$(cat "${srcinfo}" | grep "pkgver =" | cut -d'=' -f2 | xargs)
pkgrel=$(cat "${srcinfo}" | grep "pkgrel =" | cut -d'=' -f2 | xargs)
pkgname=$(cat "${srcinfo}" | grep "pkgname =" | head -n1 | cut -d'=' -f2 | xargs)
pkgarch=$(cat "${srcinfo}" | grep "arch =" | head -n1 | cut -d'=' -f2 | xargs)
pkg="${pkgname}-${pkgver}-${pkgrel}-${pkgarch}"

if curl -I --fail -s "${repo}/${pkg}.pkg.tar.zst"; then
    exit 1
fi

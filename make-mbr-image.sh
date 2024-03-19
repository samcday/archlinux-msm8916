#!/bin/bash
set -uexo pipefail

cp image.raw image.raw.mbr
sgdisk -m 1:2 image.raw.mbr
parted -s image.raw.mbr set 1 boot on

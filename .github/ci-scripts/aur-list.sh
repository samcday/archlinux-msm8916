#!/bin/bash
set -uexo pipefail

# This script determines the list of AUR packages that should be built and published to the msm8916 package repo.

packages=$(cat mkosi.conf | grep --no-group-separator -A99999 '<AUR-PACKAGES>' | tail -n+2 | grep --no-group-separator -B9999 '</AUR-PACKAGES>' | head -n-1)

echo '{"package":['
first=1
for package in $packages; do
    if [[ "$first" == "1" ]]; then
        first=0
    else
        echo -n ","
    fi
    echo -n "\"$package\""
done

echo ']}'

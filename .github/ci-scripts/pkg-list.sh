#!/bin/bash
set -uexo pipefail

# This script determines the list of aarch64 packages that should be built and published to the msm8916 package repo.
# By default it filters out packages built natively. If $NATIVE_ONLY is set, it only outputs packages built natively.

pkgbuilds=$(find PKGBUILDs/ -name 'PKGBUILD')

echo '{"package":['
first=1
for pkgbuild in $pkgbuilds; do
    dir=$(dirname $pkgbuild)
    if [[ ! -f $dir/.SRCINFO ]]; then
        continue
    fi
    if [[ -z "${NATIVE_ONLY:-}" ]] && [[ -f $dir/.nativebuild ]]; then
        continue
    elif [[ -n "${NATIVE_ONLY:-}" ]] && [[ ! -f $dir/.nativebuild ]]; then
        continue
    fi

    if [[ "$first" == "1" ]]; then
        first=0
    else
        echo -n ","
    fi
    echo -n "\"${dir#PKGBUILDs/}\""
done

echo ']}'

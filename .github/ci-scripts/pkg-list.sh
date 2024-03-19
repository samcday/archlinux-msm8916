#!/bin/bash
set -uexo pipefail

# This script determines the list of aarch64 packages that should be built and published to the msm8916 package repo.
# By default it filters out packages built natively. If $NATIVE_ONLY is set, it only outputs packages built natively.

packages=$(ls -1 PKGBUILDs)

echo '{"package":['
first=1
for package in $packages; do
    if [[ -z "${NATIVE_ONLY:-}" ]] && [[ -f PKGBUILDs/$package/.nativebuild ]]; then
        continue
    elif [[ -n "${NATIVE_ONLY:-}" ]] && [[ ! -f PKGBUILDs/$package/.nativebuild ]]; then
        continue
    fi

    if [[ "$first" == "1" ]]; then
        first=0
    else
        echo -n ","
    fi
    echo -n "\"$package\""
done

echo ']}'

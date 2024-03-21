#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: mount-userdata.sh <disk device>"
    exit 1
fi

# get userdata partition details
parted --json -s "$1" print free > /tmp/userdata-info

# get partition table type, ensure it's what we expect (GPT or MBR)
pt_type="$(jq -r '.disk.label' < /tmp/userdata-info)"
if [ "$pt_type" != "gpt" ] && [ "$pt_type" != "msdos" ]; then
    echo "WARN: $1 part table is ${pt_type} which is neither GPT nor MBR. Skipping."
    exit
fi

# check if rootfs needs resize unless skipped
if [ -z "$lk2nd_noresize" ]; then
    # get partition count, should be at least 2
    num_parts=$(jq -r '.disk.partitions | map(select(.type == "primary")) | length' < /tmp/userdata-info)
    if [ "$num_parts" -lt 2 ]; then
        echo "$1 has $num_parts partitions which is less the minimum 2 expected. Skipping resize."
    else
        # check if there's free space at end of table.
        last_part_type="$(jq -r '.disk.partitions[-1].type' < /tmp/userdata-info)"

        if [ "$last_part_type" = "free" ]; then
            # there is, do the resize.
            free="$(jq -r '.disk.partitions[-1].size' < /tmp/userdata-info)"
            resize_part="$(jq -r '.disk.partitions[-2].number' < /tmp/userdata-info)"
            if [ "$resize_part" -gt 0 ]; then
                echo "free space ($free) available at end of partition, resizing last partition (partnum ${resize_part}) to fill space"
                parted -s "$1" resizepart "${resize_part}" 100%
            fi
        fi
    fi
fi

kpartx -afs "$1"

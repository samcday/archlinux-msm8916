#!/bin/bash

if [[ -z "$1" ]]; then
    echo "Usage: mount-userdata.sh <disk device>"
    exit 1
fi

info="$(parted --json -s $1 print free)"
part_table="$(jq -r '.disk.label' <<< "$info")"

if [[ "$part_table" != "gpt" ]] && [[ "$part_table" != "msdos" ]]; then
    echo "$1 part table is ${part_table} which is neither GPT nor MBR. Skipping."
    exit 0
fi

num_parts=$(jq -r '.disk.partitions | map(select(.type == "primary")) | length' <<< "$info")
if [[ "$num_parts" == 0 ]]; then
    echo "$1 does not appear to have any primary partitions. Skipping."
    exit 0
fi

last_part_type="$(jq -r '.disk.partitions[-1].type' <<< "$info")"

if [[ "$last_part_type" == "free" ]]; then
    free="$(jq -r '.disk.partitions[-1].size' <<< "$info")"
    resize_part="$(jq -r '.disk.partitions[-2].number' <<< "$info")"
    if [[ "$resize_part" -gt 0 ]]; then
        echo "free space ($free) available at end of partition, resizing last partition (${resize_part}) to fill space"
        parted -s $1 resizepart ${resize_part} 100%
    fi
fi

kpartx -afs $1

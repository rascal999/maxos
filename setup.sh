#!/usr/bin/env bash

if [[ "$#" -ne "1" ]]; then
    echo "./setup.sh <HOSTNAME>"
    return 1
fi

#nixos-generate-config --root /mnt
#rm /mnt/etc/nixos/configuration.nix
nixos-install --flake .#$1 --root /mnt --impure

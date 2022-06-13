#!/usr/bin/env bash

if [[ "$#" -ne "1" ]]; then
    echo "./setup.sh <HOSTNAME>"
    return 1
fi

nixos-generate-config --root /mnt
rm /mnt/etc/nixos/configuration.nix

# Git repo?
if [[ -d ".git" ]]; then
  mkdir hosts/$1
  cp /mnt/etc/nixos/hardware-configuration.nix hosts/$1/

  git config --global user.email "${1}@dev.net"
  git config --global user.name "Aidan"
  git add .
  git commit -m "Host $1"
  git push
fi

echo nixos-install --flake .#$1 --root /mnt --impure

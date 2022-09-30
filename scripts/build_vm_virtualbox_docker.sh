#!/usr/bin/env sh

sysctl -w kernel.unprivileged_userns_clone=1

nix --no-net --no-substitute --extra-experimental-features "nix-command flakes" shell github:nix-community/nixos-generators -c nixos-generate --flake .#vm_virtualbox -f virtualbox

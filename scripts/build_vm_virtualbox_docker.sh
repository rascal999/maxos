#!/usr/bin/env bash

nix --no-net --no-substitute --extra-experimental-features "nix-command flakes" shell github:nix-community/nixos-generators -c nixos-generate --flake .#vm_virtualbox -f virtualbox

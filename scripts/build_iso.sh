#!/usr/bin/env bash

nix --extra-experimental-features flakes --extra-experimental-features nix-command build .#nixosConfigurations.iso.config.system.build.isoImage --impure

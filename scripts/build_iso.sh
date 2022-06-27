#!/usr/bin/env bash

nix --extra-experimental-features flakes --extra-experimental-features nix-command build .#nixosConfigurations.iso.config.system.build.isoImage --impure
/home/user/git/nixos/scripts/telegram_notify.sh "Finished building ISO."

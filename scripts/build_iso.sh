#!/usr/bin/env bash

GIT_CURRENT_HASH=`sudo -u user git -C /home/user/git/nixos rev-parse --short HEAD`
GIT_PREV_HASH=0

if [[ -f "/tmp/iso_hash" ]]; then
  GIT_PREV_HASH=`cat /tmp/iso_hash`
fi

# Check we haven't built ISO for this hash
if [[ "$GIT_CURRENT_HASH" != "$GIT_PREV_HASH" ]]; then
  nix --extra-experimental-features flakes --extra-experimental-features nix-command build .#nixosConfigurations.iso.config.system.build.isoImage --impure
  # Problem?
  if [[ "$?" == "0" ]]; then
    /home/user/git/nixos/scripts/telegram_notify.sh -m "Finished building ISO."
  else
    /home/user/git/nixos/scripts/telegram_notify.sh -m "Error code while building ISO: $?"
  fi
else
  /home/user/git/nixos/scripts/telegram_notify.sh -m "ISO already built for $GIT_CURRENT_HASH"
fi

echo $GIT_CURRENT_HASH > /tmp/iso_hash

#!/usr/bin/env bash

sudo chmod 777 /tmp/vm_virtualbox_hash

GIT_CURRENT_HASH=`sudo -u user git -C /home/user/git/maxos rev-parse --short HEAD`
GIT_PREV_HASH=0

if [[ -f "/tmp/vm_virtualbox_hash" ]]; then
  GIT_PREV_HASH=`cat /tmp/vm_virtualbox_hash`
fi

# Check we haven't built VM for this hash
if [[ "$GIT_CURRENT_HASH" != "$GIT_PREV_HASH" ]]; then
  nixos-generate --flake .#vm_virtualbox -f virtualbox -o maxos_virtualbox
  # Problem?
  if [[ "$?" == "0" ]]; then
    /home/user/git/maxos/scripts/telegram_notify.sh -m "Finished building VirtualBox VM."
    echo $GIT_CURRENT_HASH > /tmp/vm_virtualbox_hash
    exit 0
  else
    /home/user/git/maxos/scripts/telegram_notify.sh -m "Error code while building VirtualBox VM: $?"
    exit 1
  fi
else
  /home/user/git/maxos/scripts/telegram_notify.sh -m "VirtualBox VM already built for $GIT_CURRENT_HASH"
  exit 1
fi

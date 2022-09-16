#!/usr/bin/env bash

GIT_CURRENT_HASH=`sudo -u user git -C /home/user/git/maxos rev-parse --short HEAD`
GIT_PREV_HASH=0

if [[ -f "/tmp/vm_virtualbox_hash" ]]; then
  GIT_PREV_HASH=`cat /tmp/vm_virtualbox_hash`
fi

# Check we haven't built ISO for this hash
if [[ "$GIT_CURRENT_HASH" != "$GIT_PREV_HASH" ]]; then
  nixos-generate --flake .#vm_virtualbox -f virtualbox
  # Problem?
  if [[ "$?" == "0" ]]; then
    /home/user/git/maxos/scripts/telegram_notify.sh -m "Finished building VirtualBox VM."
    echo $GIT_CURRENT_HASH > /tmp/vm_virtualbox_hash
  else
    /home/user/git/maxos/scripts/telegram_notify.sh -m "Error code while building VirtualBox VM: $?"
  fi
else
  /home/user/git/maxos/scripts/telegram_notify.sh -m "VirtualBox VM already built for $GIT_CURRENT_HASH"
fi

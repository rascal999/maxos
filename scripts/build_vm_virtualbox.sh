#!/usr/bin/env bash

usage() {
  echo "Build VirtualBox VM script"
  echo "Usage: $0 -m <message> [-a] [-m] [-q]" 1>&2;
  echo
  echo "-n (Notify)           Notify on build"
  echo
  echo "Examples:"
  echo "# Do not notify"
  echo "$0 -n"
  echo
  exit 1;
}

arg_notify="true"

while getopts am:q flag
do
    case "${flag}" in
        n) arg_notify="false";;
    esac
done

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
    if [[ "$arg_notify" == "true" ]]; then
      /home/user/git/maxos/scripts/telegram_notify.sh -m "Finished building VirtualBox VM."
    fi

    echo $GIT_CURRENT_HASH > /tmp/vm_virtualbox_hash
    exit 0
  else
    if [[ "$arg_notify" == "true" ]]; then
      /home/user/git/maxos/scripts/telegram_notify.sh -m "Error code while building VirtualBox VM: $?"
    fi
    exit 1
  fi
else
  if [[ "$arg_notify" == "true" ]]; then
    /home/user/git/maxos/scripts/telegram_notify.sh -m "VirtualBox VM already built for $GIT_CURRENT_HASH"
  fi
  exit 1
fi

#!/usr/bin/env bash

usage() {
  echo "Build VirtualBox VM script"
  echo "Usage: $0 -c <vm-config> [-n]" 1>&2;
  echo
  echo "-c (Nix config)       Config to build"
  echo "-n (Don't notify)     Don't notify on build"
  echo
  echo "Examples:"
  echo "# Do not notify"
  echo "$0 -n"
  echo
  exit 1;
}

arg_notify="true"
arg_config="false"

while getopts "c:n" flag
do
    case "${flag}" in
        n) arg_notify="false";;
        c) arg_config=${OPTARG};;
    esac
done

if [[ "$arg_config" == "false" ]]; then
  echo "ERROR: VM config not provided"
  echo
  usage
fi

sudo chmod 777 /tmp/vm_virtualbox_${arg_config}_hash

GIT_CURRENT_HASH=`sudo -u user git -C /home/user/git/maxos rev-parse --short HEAD`
GIT_PREV_HASH=0

if [[ -f "/tmp/vm_virtualbox_hash" ]]; then
  GIT_PREV_HASH=`cat /tmp/vm_virtualbox_${arg_config}_hash`
fi

# Check we haven't built VM for this hash
if [[ "$GIT_CURRENT_HASH" != "$GIT_PREV_HASH" ]]; then
  nixos-generate --flake .#${arg_config} -f virtualbox -o maxos_${arg_config}
  RETURN_VALUE=$?

  # Problem?
  if [[ "$RETURN_VALUE" == "0" ]]; then
    if [[ "$arg_notify" == "true" ]]; then
      /home/user/git/maxos/scripts/telegram_notify.sh -m "Finished building VirtualBox VM"
    fi

    echo $GIT_CURRENT_HASH > /tmp/vm_virtualbox_${arg_config}_hash
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

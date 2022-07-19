#!/usr/bin/env bash

CURRENT_DIR=`pwd | choose -f "/" -1`

if [[ "$CURRENT_DIR" != "secrets" ]]; then
  echo "Run from secrets/"
  exit 1
fi

sudo nix --extra-experimental-features flakes --extra-experimental-features nix-command run github:ryantm/agenix -- --rekey --identity /etc/ssh/ssh_host_ed25519_key

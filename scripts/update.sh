#!/usr/bin/env bash

git pull
nixos-rebuild --use-remote-sudo --flake .#$HOST --impure switch
${HOME}/.startup.sh
/home/user/git/nixos/scripts/telegram_notify.sh "Finished updating."

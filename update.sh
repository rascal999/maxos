#!/usr/bin/env bash

nixos-rebuild --use-remote-sudo --flake .#$HOST --impure switch

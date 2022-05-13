#!/usr/bin/env bash

sudo nixos-rebuild --flake .#$HOST --impure switch

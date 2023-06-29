#!/usr/bin/env bash

/run/current-system/sw/bin/keepassxc &
/etc/profiles/per-user/user/bin/i3-msg 'workspace pw'

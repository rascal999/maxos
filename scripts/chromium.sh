#!/usr/bin/env bash

/etc/profiles/per-user/user/bin/chromium --force-device-scale-factor=1.6 &
/etc/profiles/per-user/user/bin/i3-msg 'workspace chr'

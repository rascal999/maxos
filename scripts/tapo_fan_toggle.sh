#!/usr/bin/env bash

/run/current-system/sw/bin/docker run -e TAPO_USERNAME=`cat /etc/api-tapo-username` -e TAPO_PASSWORD=`cat /etc/api-tapo-password` --rm redgo /root/tapo_fan_toggle.py

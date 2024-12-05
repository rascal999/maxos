#!/usr/bin/env bash

TOUCHPAD_ID=`xinput list | grep -i touchpad | cut -f 2 | sed 's/id=//g'`

if [[ "$TOUCHPAD_ID" == "" ]]; then
    echo "ERROR: Touchpad not found"
    exit 1
fi

DISABLED=`xinput list $TOUCHPAD_ID | grep disabled | wc -l`

xinput set-prop $TOUCHPAD_ID "Device Enabled" $DISABLED

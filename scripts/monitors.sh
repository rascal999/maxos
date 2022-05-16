#!/usr/bin/env bash

if [[ `hostname` == "rig" ]]; then
    sleep 3

    # 0
    /run/current-system/sw/bin/xrandr --output DP-4 --auto --right-of HDMI-0
    # 2
    /run/current-system/sw/bin/xrandr --output USB-C-0 --auto --left-of HDMI-0

    sleep 3

    i3-msg "workspace 1, move workspace to output HDMI-0"
    i3-msg "workspace 2, move workspace to output USB-C-0"
    i3-msg "workspace 7, move workspace to output DP-4"

    for WORKSPACE_FILE in "$@" ; do
      WORKSPACE_NUM=`echo $WORKSPACE_FILE | gawk -F '-' '{ print $NF }' | grep -o "[0-9]"`
      i3-msg "workspace $WORKSPACE_NUM; append_layout $WORKSPACE_FILE"
    done

    sleep 3

    /run/current-system/sw/bin/obsidian &
    /run/current-system/sw/bin/firefox -P "Default" &
    /run/current-system/sw/bin/slack &
fi

if [[ `hostname` == "galaxy" ]]; then
    sleep 3 
    /run/current-system/sw/bin/xrandr --output HDMI-1 --off
    sleep 3 
    /run/current-system/sw/bin/xrandr --output HDMI-1 --auto --right-of eDP-1
fi

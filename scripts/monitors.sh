#!/usr/bin/env bash

if [[ `hostname` == "rig" ]]; then
    sleep 2

    # 0
    /run/current-system/sw/bin/xrandr --output HDMI-0 --auto --left-of DP-4
    # 2
    /run/current-system/sw/bin/xrandr --output USB-C-0 --auto --right-of DP-4

    #sleep 4

    i3-msg "workspace 10, move workspace to output HDMI-0"
    i3-msg "workspace 7, move workspace to output DP-4"
    i3-msg "workspace 2, move workspace to output USB-C-0"
    i3-msg "workspace 1, move workspace to output USB-C-0"

    for WORKSPACE_FILE in "$@" ; do
      WORKSPACE_NUM=`echo $WORKSPACE_FILE | gawk -F '-' '{ print $NF }' | grep -Eo "[0-9]{1,3}"`
      i3-msg "workspace $WORKSPACE_NUM; append_layout $WORKSPACE_FILE"
    done
fi

if [[ `hostname` == "galaxy" ]]; then
    sleep 4
    /run/current-system/sw/bin/xrandr --output HDMI1 --off
    sleep 4
    /run/current-system/sw/bin/xrandr --output HDMI1 --auto --right-of eDP1
fi

#!/usr/bin/env bash

if [[ `hostname` == "rig" ]]; then
    sleep 3

    # 0
    /run/current-system/sw/bin/xrandr --output HDMI-0 --auto --left-of DP-4
    # 1
    /run/current-system/sw/bin/xrandr --output DP-4 --auto --right-of HDMI-0
    # 2
    /run/current-system/sw/bin/xrandr --output USB-C-0 --primary --auto --right-of DP-4

    sleep 4

    /etc/profiles/per-user/user/bin/i3-msg "workspace ytm, move workspace to output DP-4"
    sleep 1
    /etc/profiles/per-user/user/bin/i3-msg "workspace vid, move workspace to output HDMI-0"
    sleep 1
    /etc/profiles/per-user/user/bin/i3-msg "workspace 2:ls, move workspace to output USB-C-0"
    sleep 1
    /etc/profiles/per-user/user/bin/i3-msg "workspace vm, move workspace to output USB-C-0"
    sleep 1
    /etc/profiles/per-user/user/bin/i3-msg "workspace 1, move workspace to output USB-C-0"
    sleep 1

    /etc/profiles/per-user/user/bin/i3-msg "workspace vid; append_layout /home/user/git/maxos/hosts/rig/i3/vid.json"
    /etc/profiles/per-user/user/bin/i3-msg "workspace ytm; append_layout /home/user/git/maxos/hosts/rig/i3/ytm.json"
    #for WORKSPACE_FILE in "$@" ; do
    #  WORKSPACE_NUM=`echo $WORKSPACE_FILE | gawk -F '-' '{ print $NF }' | grep -Eo "[0-9]{1,3}"`
    #  /etc/profiles/per-user/user/bin/i3-msg "workspace $WORKSPACE_NUM; append_layout $WORKSPACE_FILE"
    #done
fi

if [[ `hostname` == "galaxy" ]]; then
    sleep 4
    /run/current-system/sw/bin/xrandr --output HDMI1 --off
    sleep 4
    /run/current-system/sw/bin/xrandr --output HDMI1 --auto --right-of eDP1
fi

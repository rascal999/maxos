#!/usr/bin/env bash

if [[ `hostname` == "rig" ]]; then
    /run/current-system/sw/bin/sleep 3

    # 0
    /run/current-system/sw/bin/xrandr --output HDMI-0 --auto --left-of DP-0
    # 1
    /run/current-system/sw/bin/xrandr --output DP-0 --auto --right-of HDMI-0
    # 2
    /run/current-system/sw/bin/xrandr --output USB-C-0 --primary --auto --right-of DP-0

    /run/current-system/sw/bin/sleep 4

    /etc/profiles/per-user/user/bin/i3-msg "workspace vid; append_layout /home/user/git/maxos/hosts/rig/i3/vid.json"
    /etc/profiles/per-user/user/bin/i3-msg "workspace ytm; append_layout /home/user/git/maxos/hosts/rig/i3/ytm.json"

    /run/current-system/sw/bin/sleep 1

    /etc/profiles/per-user/user/bin/i3-msg "workspace ytm, move workspace to output DP-0"
    /run/current-system/sw/bin/sleep 1
    /etc/profiles/per-user/user/bin/i3-msg "workspace vid, move workspace to output HDMI-0"
    /run/current-system/sw/bin/sleep 1
    /etc/profiles/per-user/user/bin/i3-msg "workspace 2:ls, move workspace to output USB-C-0"
    /run/current-system/sw/bin/sleep 1
    /etc/profiles/per-user/user/bin/i3-msg "workspace vm, move workspace to output USB-C-0"
    /run/current-system/sw/bin/sleep 1
    /etc/profiles/per-user/user/bin/i3-msg "workspace 1, move workspace to output USB-C-0"
    /run/current-system/sw/bin/sleep 1

    ### Apps
    /run/current-system/sw/bin/daemon /run/current-system/sw/bin/copyq
    /run/current-system/sw/bin/sleep 0.2
    /run/current-system/sw/bin/daemon -X "/run/current-system/sw/bin/nvidia-settings -a GPUFanControlState=1 -a GPUTargetFanSpeed=40"
    /run/current-system/sw/bin/sleep 0.2
    /run/current-system/sw/bin/redshift -O 1900
    /run/current-system/sw/bin/sleep 0.2
    /run/current-system/sw/bin/daemon /etc/profiles/per-user/user/bin/firefox
    /run/current-system/sw/bin/sleep 0.2
    /run/current-system/sw/bin/daemon -X "/etc/profiles/per-user/user/bin/chromium --force-device-scale-factor=1.6"
    /run/current-system/sw/bin/sleep 0.2
    /run/current-system/sw/bin/daemon /run/current-system/sw/bin/logseq
    /run/current-system/sw/bin/sleep 0.2
    /run/current-system/sw/bin/daemon /run/current-system/sw/bin/slack
    /run/current-system/sw/bin/sleep 0.2
    /run/current-system/sw/bin/daemon -X "/etc/profiles/per-user/user/bin/chromium --force-device-scale-factor=1.6 --new-window --app=http://127.0.0.1:10220/"
    /run/current-system/sw/bin/sleep 0.2
    /run/current-system/sw/bin/daemon -X "/run/current-system/sw/bin/mpv https://www.bloomberg.com/media-manifest/streams/eu.m3u8"
    /run/current-system/sw/bin/sleep 0.2
    /run/current-system/sw/bin/daemon -X "/run/current-system/sw/bin/mpv https://dwamdstream102.akamaized.net/hls/live/2015525/dwstream102/index.m3u8"
    /run/current-system/sw/bin/sleep 0.2
    /run/current-system/sw/bin/daemon -X "/run/current-system/sw/bin/mpv https://cd-live-stream.news.cctvplus.com/live/smil:CHANNEL2.smil/playlist.m3u8"
    /run/current-system/sw/bin/sleep 0.2
    /run/current-system/sw/bin/daemon -X "/run/current-system/sw/bin/mpv https://cnn-cnninternational-1-eu.rakuten.wurl.tv/playlist.m3u8"

    #for WORKSPACE_FILE in "$@" ; do
    #  WORKSPACE_NUM=`echo $WORKSPACE_FILE | gawk -F '-' '{ print $NF }' | grep -Eo "[0-9]{1,3}"`
    #  /etc/profiles/per-user/user/bin/i3-msg "workspace $WORKSPACE_NUM; append_layout $WORKSPACE_FILE"
    #done
fi

if [[ `hostname` == "galaxy" ]]; then
    /run/current-system/sw/bin/sleep 4
    /run/current-system/sw/bin/xrandr --output HDMI1 --off
    /run/current-system/sw/bin/sleep 4
    /run/current-system/sw/bin/xrandr --output HDMI1 --auto --right-of eDP1
fi

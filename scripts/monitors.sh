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

    ### Apps
    /run/current-system/sw/bin/screen -adm /run/current-system/sw/bin/copyq
    /run/current-system/sw/bin/screen -adm /run/current-system/sw/bin/nvidia-settings -a GPUFanControlState=1 -a GPUTargetFanSpeed=40
    /run/current-system/sw/bin/screen -adm /run/current-system/sw/bin/redshift -O 1900
    /run/current-system/sw/bin/screen -adm /etc/profiles/per-user/user/bin/firefox
    /run/current-system/sw/bin/screen -adm /run/current-system/sw/bin/VirtualBox
    /run/current-system/sw/bin/screen -adm /etc/profiles/per-user/user/bin/chromium --force-device-scale-factor=1.6
    /run/current-system/sw/bin/screen -adm /etc/profiles/per-user/user/bin/chromium --app=http://localhost
    /run/current-system/sw/bin/screen -adm /run/current-system/sw/bin/logseq
    /run/current-system/sw/bin/screen -adm /run/current-system/sw/bin/slack
    /run/current-system/sw/bin/screen -adm /run/current-system/sw/bin/vlc https://dwamdstream102.akamaized.net/hls/live/2015525/dwstream102/index.m3u8
    /run/current-system/sw/bin/screen -adm /run/current-system/sw/bin/vlc https://d1mpprlbe8tn2j.cloudfront.net/v1/master/7b67fbda7ab859400a821e9aa0deda20ab7ca3d2/euronewsLive/87O7AhxRUdeeIVqf/ewnsabren_eng.m3u8
    /run/current-system/sw/bin/screen -adm /run/current-system/sw/bin/vlc https://cnn-cnninternational-1-eu.rakuten.wurl.tv/playlist.m3u8
    /run/current-system/sw/bin/screen -adm /run/current-system/sw/bin/vlc https://cd-live-stream.news.cctvplus.com/live/smil:CHANNEL2.smil/playlist.m3u8

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

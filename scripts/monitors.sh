#!/usr/bin/env bash

# Function to move a workspace to a different output
move_workspace() {
  local workspace_name=$1
  local output_name=$2

  # Switch to a temporary workspace
  i3-msg "workspace tmp"

  # Move the target workspace to the desired output
  i3-msg "workspace $workspace_name, move workspace to output $output_name"
}

if [[ `hostname` == "rig" ]]; then
    /run/current-system/sw/bin/sleep 3

    # 0
    /run/current-system/sw/bin/xrandr --output DP-4 --left-of DP-2 --mode 2560x1440 --rate 144
    # 1
    /run/current-system/sw/bin/xrandr --output DP-2 --primary --right-of DP-4 --mode 3440x1440 --rate 144
    # 2
    /run/current-system/sw/bin/xrandr --output HDMI-0 --right-of DP-2 --mode 2560x1440 --rate 60

    /run/current-system/sw/bin/sleep 4

    #/etc/profiles/per-user/user/bin/i3-msg "workspace vid; append_layout /home/user/git/maxos/hosts/rig/i3/vid.json"
    /etc/profiles/per-user/user/bin/i3-msg "workspace ytm; append_layout /home/user/git/maxos/hosts/rig/i3/ytm.json"

    ### Apps
    /run/current-system/sw/bin/daemon /home/user/git/maxos/resources/greenclip daemon
    /run/current-system/sw/bin/daemon /run/current-system/sw/bin/copyq
    #/run/current-system/sw/bin/daemon -X "/run/current-system/sw/bin/nvidia-settings -a GPUFanControlState=1 -a GPUTargetFanSpeed=40"
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
    #/run/current-system/sw/bin/daemon -X "/etc/profiles/per-user/user/bin/chromium --force-device-scale-factor=1.6 --new-window --app=http://127.0.0.1:10220/"
    #/run/current-system/sw/bin/sleep 0.2
    #/run/current-system/sw/bin/daemon -X "/run/current-system/sw/bin/mpv https://www.bloomberg.com/media-manifest/streams/eu.m3u8"
    #/run/current-system/sw/bin/sleep 0.2
    #/run/current-system/sw/bin/daemon -X "/run/current-system/sw/bin/mpv https://dwamdstream102.akamaized.net/hls/live/2015525/dwstream102/index.m3u8"
    #/run/current-system/sw/bin/sleep 0.2
    #/run/current-system/sw/bin/daemon -X "/run/current-system/sw/bin/mpv https://cd-live-stream.news.cctvplus.com/live/smil:CHANNEL2.smil/playlist.m3u8"
    #/run/current-system/sw/bin/sleep 0.2
    #/run/current-system/sw/bin/daemon -X "/run/current-system/sw/bin/mpv https://cnn-cnninternational-1-eu.rakuten.wurl.tv/playlist.m3u8"

    #for WORKSPACE_FILE in "$@" ; do
    #  WORKSPACE_NUM=`echo $WORKSPACE_FILE | gawk -F '-' '{ print $NF }' | grep -Eo "[0-9]{1,3}"`
    #  /etc/profiles/per-user/user/bin/i3-msg "workspace $WORKSPACE_NUM; append_layout $WORKSPACE_FILE"
    #done

    /run/current-system/sw/bin/sleep 2

    move_workspace "1" "DP-2"
    move_workspace "2:ls" "DP-2"
    move_workspace "vm" "DP-2"
    move_workspace "ytm" "HDMI-0"
fi


if [[ `hostname` == "mac" ]]; then
    /run/current-system/sw/bin/sleep 3

    # 0
    #/run/current-system/sw/bin/xrandr --output DP-4 --left-of DP-2 --mode 2560x1440 --rate 144
    # 1
    #/run/current-system/sw/bin/xrandr --output DP-2 --primary --right-of DP-4 --mode 3440x1440 --rate 144
    # 2
    #/run/current-system/sw/bin/xrandr --output HDMI-0 --right-of DP-2 --mode 2560x1440 --rate 60

    #/run/current-system/sw/bin/sleep 4

    #/etc/profiles/per-user/user/bin/i3-msg "workspace vid; append_layout /home/user/git/maxos/hosts/rig/i3/vid.json"
    #/etc/profiles/per-user/user/bin/i3-msg "workspace ytm; append_layout /home/user/nixos/hosts/mac/i3/ytm.json"

    ### Apps
    /run/current-system/sw/bin/daemon /home/user/nixos/resources/greenclip daemon
    /run/current-system/sw/bin/daemon /run/current-system/sw/bin/copyq
    #/run/current-system/sw/bin/daemon -X "/run/current-system/sw/bin/nvidia-settings -a GPUFanControlState=1 -a GPUTargetFanSpeed=40"
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
    #/run/current-system/sw/bin/daemon -X "/etc/profiles/per-user/user/bin/chromium --force-device-scale-factor=1.6 --new-window --app=http://127.0.0.1:10220/"
    #/run/current-system/sw/bin/sleep 0.2
    #/run/current-system/sw/bin/daemon -X "/run/current-system/sw/bin/mpv https://www.bloomberg.com/media-manifest/streams/eu.m3u8"
    #/run/current-system/sw/bin/sleep 0.2
    #/run/current-system/sw/bin/daemon -X "/run/current-system/sw/bin/mpv https://dwamdstream102.akamaized.net/hls/live/2015525/dwstream102/index.m3u8"
    #/run/current-system/sw/bin/sleep 0.2
    #/run/current-system/sw/bin/daemon -X "/run/current-system/sw/bin/mpv https://cd-live-stream.news.cctvplus.com/live/smil:CHANNEL2.smil/playlist.m3u8"
    #/run/current-system/sw/bin/sleep 0.2
    #/run/current-system/sw/bin/daemon -X "/run/current-system/sw/bin/mpv https://cnn-cnninternational-1-eu.rakuten.wurl.tv/playlist.m3u8"

    #for WORKSPACE_FILE in "$@" ; do
    #  WORKSPACE_NUM=`echo $WORKSPACE_FILE | gawk -F '-' '{ print $NF }' | grep -Eo "[0-9]{1,3}"`
    #  /etc/profiles/per-user/user/bin/i3-msg "workspace $WORKSPACE_NUM; append_layout $WORKSPACE_FILE"
    #done

    /run/current-system/sw/bin/sleep 2

   # move_workspace "1" "DP-2"
   # move_workspace "2:ls" "DP-2"
   # move_workspace "vm" "DP-2"
   # move_workspace "ytm" "HDMI-0"
fi

if [[ `hostname` == "galaxy" ]]; then
    /run/current-system/sw/bin/sleep 4
    /run/current-system/sw/bin/xrandr --output HDMI1 --off
    /run/current-system/sw/bin/sleep 4
    /run/current-system/sw/bin/xrandr --output HDMI1 --auto --right-of eDP1
fi

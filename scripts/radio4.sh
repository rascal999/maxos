#!/usr/bin/env bash

R4_RUNNING=`ps auxf | grep vlc | grep radio_four | wc -l`

if [[ "$R4_RUNNING" == "1" ]]; then
    R4_PID=`ps auxf | grep vlc | grep radio_four | choose 1`
    kill $R4_PID
else
    vlc --qt-start-minimized "http://as-hls-ww-live.akamaized.net/pool_904/live/ww/bbc_radio_fourfm/bbc_radio_fourfm.isml/bbc_radio_fourfm-audio%3d96000.norewind.m3u8"
fi

#!/usr/bin/env bash

xdotool key Alt+2
WID=`xdotool search --onlyvisible --classname logseq`
xdotool windowfocus --sync $WID
xdotool key --delay 150 Escape
xdotool key --delay 150 Escape
xdotool key --delay 150 "g"
xdotool key --delay 150 "j"
xdotool key --delay 150 Down
xdotool key --delay 150 T
xdotool key --delay 150 O
TIME=`date +"%H:%M"`
xdotool type --delay 150 "$TIME"
xdotool key --delay 150 Enter
xdotool key --delay 150 Tab

#!/usr/bin/env bash

DELAY=400

xdotool key Alt+2
echo "Alt+2 keys"

WID=`xdotool search --onlyvisible --classname logseq`
xdotool windowfocus --sync $WID

xdotool key --delay $DELAY Escape
echo "Escape key"

xdotool key --delay $DELAY Escape
echo "Escape key"

xdotool key --delay $DELAY "g"
echo "Pressed g"

xdotool key --delay $DELAY "j"
echo "Pressed j"

xdotool key --delay $DELAY Down
echo "Down key"

xdotool key --delay $DELAY T
echo "Pressed T"

xdotool key --delay $DELAY O
echo "Pressed O"

sleep 0.2

TIME=`date +"%H:%M"`
xdotool type --delay 100 "$TIME"
echo $TIME

xdotool key --delay $DELAY Enter
echo "Enter key"

xdotool key --delay $DELAY Tab
echo "Tab key"

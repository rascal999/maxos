#!/usr/bin/env bash

if [[ "$#" != "3" ]]; then
    echo "$0 <display> <workspace-1> <workspace-2>"
    exit 1
fi

# Get the display name (e.g., HDMI-1, VGA-1)
display_name="$1"

# Get the visible workspace for the specified display
visible_workspace=$(i3-msg -t get_workspaces | jq -r "map(select(.output == \"$display_name\" and .visible))[0].name")

if [[ "$visible_workspace" == "$3" ]]; then
    # Second time
    i3-msg "workspace $2"

    xdotool mousemove "`cat /tmp/x_mouse`" "`cat /tmp/y_mouse`"
else
    X_MOUSE=`xdotool getmouselocation | choose 0 | choose -f ":" 1`
    Y_MOUSE=`xdotool getmouselocation | choose 1 | choose -f ":" 1`

    echo $X_MOUSE > /tmp/x_mouse
    echo $Y_MOUSE > /tmp/y_mouse

    # First time
    i3-msg "workspace $3"
fi

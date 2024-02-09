#!/usr/bin/env bash

# Check if xdotool is installed
if ! command -v xdotool &> /dev/null; then
    echo "Error: xdotool is not installed. Please install it."
    exit 1
fi

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <workspace> <label>"
    exit 1
fi

# Move to correct workspace
/etc/profiles/per-user/user/bin/i3-msg "workspace $1"

TILE_COUNT=`/etc/profiles/per-user/user/bin/i3-save-tree | grep class | wc -l`

y_coord=290
# Define label-to-coordinates mappings
case "$2" in
    "ynab")
        x_coord=5150
        ;;
    "calendar")
        y_coord=340
        x_coord=5190
        ;;
    "gpt")
        x_coord=5340
        ;;
    "sprint_1")
        y_coord=340
        x_coord=5290
        ;;
    "sprint_2")
        y_coord=340
        x_coord=5340
        ;;
    "sprint_3")
        y_coord=340
        x_coord=5390
        ;;
    # Add more label mappings as needed
    *)
        echo "Invalid label. Supported labels: button, menu"
        exit 1
        ;;
esac

if [[ "$TILE_COUNT" == "2" ]]; then
    y_coord=$((y_coord+50))
fi

# Move mouse to specified coordinates
xdotool mousemove "$x_coord" "$y_coord"

# Simulate a left mouse button click
#xdotool click 1

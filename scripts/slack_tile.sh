#!/usr/bin/env bash

SLACK_FS=`i3-msg -t get_tree | jq -r '.nodes[].nodes[].nodes[].nodes[] | select(.window_properties.class == "Slack") | .fullscreen_mode'`

SLACK_PARKED=`i3-save-tree --workspace ytm | grep class | grep Slack | wc -l`

# Park
if [ "$1" == "park" ]; then
  i3-msg "[class=\"Slack\"] move to workspace ytm"
  sleep 0.3

  # If fs, unset fs
  if [ "$SLACK_FS" == "1" ]; then
      i3-msg "[class=\"Slack\"] fullscreen"
  fi
fi

# Desire to fullscreen
if [ "${SLACK_PARKED}" == "1" ]; then
  i3-msg "[class=\"Slack\"] move to workspace 1"
  sleep 0.3
  i3-msg "[class=\"Slack\"] focus"
  #xdotool mousemove --screen 0 5290 160
fi

# Focus workspace 1 exits fullscreen for app
if [ "$1" == "fullscreen" ]; then
  # If not fs, set fs
  if [ "$SLACK_FS" != "1" ]; then
      i3-msg "[class=\"Slack\"] fullscreen"
  fi
fi

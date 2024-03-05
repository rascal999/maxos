#!/usr/bin/env bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <team> <id>"
    exit 1
fi

function slack() {
    /home/user/git/maxos/scripts/slack_fs.sh fullscreen
    # T02ER9ABV U04GGBDUWH0
    /run/current-system/sw/bin/xdg-open "slack://channel?team=${1}&id=${2}"
}

slack $@

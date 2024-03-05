#!/usr/bin/env bash

sleep 0.2

# Check if xdotool is installed
if ! command -v xdotool &> /dev/null; then
    echo "Error: xdotool is not installed. Please install it."
    exit 1
fi

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <action> <workspace> <label>"
    exit 1
fi

function misc() {
    case "$3" in
        "ollama-llama2")
            CONTAINER_ID=`docker ps --format "{{.ID}}" -f name="ollama$"`
            if [[ "$CONTAINER_ID" != "" ]]; then
                /run/current-system/sw/bin/urxvt -bg black -fg white -e /etc/profiles/per-user/user/bin/tmux new-session -e OLLAMA_LLAMA2=1
            fi
        ;;
        "ollama-mistral")
            CONTAINER_ID=`docker ps --format "{{.ID}}" -f name="ollama$"`
            if [[ "$CONTAINER_ID" != "" ]]; then
                /run/current-system/sw/bin/urxvt -bg black -fg white -e /etc/profiles/per-user/user/bin/tmux new-session -e OLLAMA_MISTRAL=1
            fi
        ;;
        "refresh")
            xdotool key F5
        ;;
        # Add more label mappings as needed
        *)
            echo "Invalid label."
            exit 1
            ;;
    esac
}

function slack() {
    /etc/profiles/per-user/user/bin/i3-msg "[class=\"^Slack$\"] focus"
    case "$3" in
        "slack_jeremy")
            /run/current-system/sw/bin/xdg-open "slack://channel?team=T02ER9ABV&id=U04GGBDUWH0"
            ;;
        "slack_pierre")
            /run/current-system/sw/bin/xdg-open "slack://channel?team=T02ER9ABV&id=U06G9SFKAJ2"
            ;;
        "slack_security_squad")
            /run/current-system/sw/bin/xdg-open "slack://channel?team=T02ER9ABV&id=C050ZTPBV4H"
            ;;
        "slack_mathieu")
            /run/current-system/sw/bin/xdg-open "slack://channel?team=T02ER9ABV&id=U05C566PDJ5"
            ;;
        # Add more label mappings as needed
        *)
            echo "Invalid label."
            exit 1
            ;;
    esac
}

function click() {
    X_MOUSE=`xdotool getmouselocation | choose 0 | choose -f ":" 1`
    Y_MOUSE=`xdotool getmouselocation | choose 1 | choose -f ":" 1`

    # Move to correct workspace
    /etc/profiles/per-user/user/bin/i3-msg "workspace $2"

    TILE_COUNT=`/etc/profiles/per-user/user/bin/i3-save-tree | grep class | wc -l`

    y_coord=290
    # Define label-to-coordinates mappings
    case "$3" in
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
            echo "Invalid label."
            exit 1
            ;;
    esac

    if [[ "$TILE_COUNT" == "2" ]]; then
        y_coord=$((y_coord+50))
    fi

    # Move mouse to specified coordinates
    xdotool mousemove "$x_coord" "$y_coord"

    # Simulate a left mouse button click
    xdotool click 1

    # Return to previous location
    xdotool mousemove "$X_MOUSE" "$Y_MOUSE"
}

if [ "$1" == "misc" ]; then
    misc $@
fi

if [ "$1" == "click" ]; then
    click $@
fi

if [ "$1" == "slack" ]; then
    slack $@
fi

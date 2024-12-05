#!/usr/bin/env bash

# Function to prompt the user for input with a default value
prompt() {
    local prompt_text=$1
    local default_value=$2
    local user_input

    read -p "$prompt_text [$default_value]: " user_input
    echo "${user_input:-$default_value}"
}

# Function to get the nearest quarter hour time
nearest_quarter_hour() {
    local current_minute=$(date +%M)
    local current_hour=$(date +%H)
    local nearest_minute=$(( (current_minute + 14) / 15 * 15 ))

    if [ $nearest_minute -ge 60 ]; then
        nearest_minute=0
        current_hour=$(( (current_hour + 1) % 24 ))
    fi

    printf "%02d:%02d" $current_hour $nearest_minute
}

# Function to convert duration to minutes
convert_duration_to_minutes() {
    local duration=$1
    if [[ $duration =~ ^([0-9]+)m$ ]]; then
        echo "${BASH_REMATCH[1]}"
    elif [[ $duration =~ ^([0-9]+)h$ ]]; then
        echo "$(( ${BASH_REMATCH[1]} * 60 ))"
    else
        echo "Invalid duration format. Please specify in 'Nm' or 'Nh' format."
        exit 1
    fi
}

# Get today's date
today=$(date +%Y-%m-%d)

# Get the nearest quarter hour
default_start_time=$(nearest_quarter_hour)

# Get the event details from the user
event_date=$(prompt "Enter the event date (YYYY-MM-DD)" "$today")
start_time=$(prompt "Enter the start time (HH:MM)" "$default_start_time")
duration=$(prompt "Enter the duration of the meeting (e.g., 90m or 1h)" "30m")
summary=$(prompt "Enter the event summary" "Meeting")

# Convert the duration to minutes
duration_minutes=$(convert_duration_to_minutes "$duration")

# Calculate end time based on start time and duration
end_time=$(date -d "$event_date $start_time" +%s)
end_time=$(( end_time + duration_minutes * 60 ))
end_time=$(date -d "@$end_time" +%H:%M)

# Create the event using khal
khal new "$event_date" "$start_time" "$end_time" "$summary"

# Sync the calendar using vdirsyncer
vdirsyncer sync

echo "Event created and calendar synced successfully."

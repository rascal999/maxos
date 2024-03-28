#!/usr/bin/env bash

# Path to Firefox profile directory
PROFILE_DIR="$HOME/.mozilla/firefox/default/"

# Locate the Firefox profile directory
PROFILE_PATH=$(find "$PROFILE_DIR" -maxdepth 1 -type d -name '*.default*' -print -quit)

# DB lock if FF open bypass
cp "$PROFILE_DIR/places.sqlite" "$PROFILE_DIR/tmp.sqlite"

# Firefox history database file
HISTORY_DB="$PROFILE_DIR/tmp.sqlite"

# Check if the history database file exists
if [ ! -f "$HISTORY_DB" ]; then
    echo "Firefox history database not found."
    exit 1
fi

# Query Firefox history and format data
sqlite3 -separator ' | ' "$HISTORY_DB" <<EOF
.headers off
SELECT '⏳ FF History # ' || REPLACE(title, '|', '#') || ' | ' || url FROM moz_places;
EOF

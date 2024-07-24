#!/usr/bin/env bash

ROFI_CMD="rofi"

# Path to your SQLite database file
DB_FILE="/home/user/Data/resources/rofi-workspace.db"

# SQLite query to select entries and commands from your database
QUERY="SELECT entry_name, command FROM rofi;"

# Execute the SQLite query and store the results in a variable
ENTRIES=$(sqlite3 "$DB_FILE" "$QUERY")

# Want history last
ENTRIES_SORTED=$(echo "$ENTRIES" | sort)
ENTRIES="${ENTRIES_SORTED}"

# Use $ROFI_CMD to display the entries and select one
SELECTED_ENTRY=$(echo "$ENTRIES" | cut -d '|' -f 1 | $ROFI_CMD -i -dmenu -p "Workspace >")

# Find the corresponding command for the selected entry
SELECTED_COMMAND=$(echo "$ENTRIES" | grep "^$SELECTED_ENTRY|" | cut -d '|' -f 2)

case "$SELECTED_COMMAND" in
    activity)
        i3-msg "workspace # Activity"
        firefox -P "MP Activity"
    ;;
    apm)
        i3-msg "workspace # APM"
        firefox -P "MP APM"
    ;;
    activity)
        i3-msg "workspace # Banking Extensions"
        firefox -P "MP Banking Extensions"
    ;;
    activity)
        i3-msg "workspace # Cards Connectors"
        firefox -P "MP Cards Connectors"
    ;;
    activity)
        i3-msg "workspace # Checkout"
        firefox -P "MP Checkout"
    ;;
    activity)
        i3-msg "workspace # Core Tech"
        firefox -P "MP Core Tech"
    ;;
    activity)
        i3-msg "workspace # Experience"
        firefox -P "MP Experience"
    ;;
    activity)
        i3-msg "workspace # Identity"
        firefox -P "MP Identity"
    ;;
    activity)
        i3-msg "workspace # NTH > API"
        firefox -P "MP NTH API"
    ;;
    activity)
        i3-msg "workspace # NTH > Panel"
        firefox -P "MP NTH Panel"
    ;;
    activity)
        i3-msg "workspace # NTH > Profiler"
        firefox -P "MP NTH Profiler"
    ;;
    activity)
        i3-msg "workspace # Payments Platform"
        firefox -P "MP Payment Platform"
    ;;
    activity)
        i3-msg "workspace # Payout Connector"
        firefox -P "MP Payout Connector"
    ;;
    activity)
        i3-msg "workspace # Payout Recipient"
        firefox -P "MP Payout Recipient"
    ;;
    activity)
        i3-msg "workspace # Salesforce"
        firefox -P "MP Salesforce"
    ;;
    activity)
        i3-msg "workspace # Smart Wallet"
        firefox -P "MP Smart Wallet"
    ;;
    activity)
        i3-msg "workspace # SRE Team"
        firefox -P "MP SRE Team"
    ;;
esac

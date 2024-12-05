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
        WORKSPACE_NAME="# Activity"
        WORKSPACE_PROFILE="MP Activity"
    ;;
    apm)
        WORKSPACE_NAME="# APM"
        WORKSPACE_PROFILE="MP APM"
    ;;
    banking_extensions)
        WORKSPACE_NAME="# Banking Extensions"
        WORKSPACE_PROFILE="MP Banking Extensions"
    ;;
    cards_connectors)
        WORKSPACE_NAME="# Cards Connectors"
        WORKSPACE_PROFILE="MP Cards Connectors"
    ;;
    checkout)
        WORKSPACE_NAME="# Checkout"
        WORKSPACE_PROFILE="MP Checkout"
    ;;
    core_tech)
        WORKSPACE_NAME="# Core Tech"
        WORKSPACE_PROFILE="MP Core Tech"
    ;;
    experience)
        WORKSPACE_NAME="# Experience"
        WORKSPACE_PROFILE="MP Experience"
    ;;
    identity)
        WORKSPACE_NAME="# Identity"
        WORKSPACE_PROFILE="MP Identity"
    ;;
    monolith)
        WORKSPACE_NAME="# Monolith"
        WORKSPACE_PROFILE="MP Monolith"
    ;;
    nth_api)
        WORKSPACE_NAME="# NTH > API"
        WORKSPACE_PROFILE="MP NTH API"
    ;;
    nth_panel)
        WORKSPACE_NAME="# NTH > Panel"
        WORKSPACE_PROFILE="MP NTH Panel"
    ;;
    nth_profiler)
        WORKSPACE_NAME="# NTH > Profiler"
        WORKSPACE_PROFILE="MP NTH Profiler"
    ;;
    payments_platform)
        WORKSPACE_NAME="# Payments Platform"
        WORKSPACE_PROFILE="MP Payments Platform"
    ;;
    payout_connectors)
        WORKSPACE_NAME="# Payout Connectors"
        WORKSPACE_PROFILE="MP Payout Connectors"
    ;;
    payout_core)
        WORKSPACE_NAME="# Payout Core"
        WORKSPACE_PROFILE="MP Payout Core"
    ;;
    payout_recipient)
        WORKSPACE_NAME="# Payout Recipient"
        WORKSPACE_PROFILE="MP Payout Recipient"
    ;;
    qa_platform)
        WORKSPACE_NAME="# QA Platform"
        WORKSPACE_PROFILE="MP QA Platform"
    ;;
    salesforce)
        WORKSPACE_NAME="# Salesforce"
        WORKSPACE_PROFILE="MP Salesforce"
    ;;
    smart_wallet)
        WORKSPACE_NAME="# Smart Wallet"
        WORKSPACE_PROFILE="MP Smart Wallet"
    ;;
    sre_team)
        WORKSPACE_NAME="# SRE Team"
        WORKSPACE_PROFILE="MP SRE Team"
    ;;
esac

echo "Workspace name:    $WORKSPACE_NAME"
echo "Workspace profile: $WORKSPACE_PROFILE"
WORKSPACE_CREATED=`i3-save-tree --workspace "${WORKSPACE_NAME}" | grep firefox | wc -l`

if [[ $WORKSPACE_CREATED == 0 ]]; then
    # FUCK ME https://github.com/i3/i3/issues/4846
    i3-msg "workspace $WORKSPACE_NAME; exec --no-startup-id firefox -P \"$WORKSPACE_PROFILE\""
else
    i3-msg "workspace $WORKSPACE_NAME"
fi

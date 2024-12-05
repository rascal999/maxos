#!/usr/bin/env bash

ROFI_CMD="rofi"

# Firefox history
ENTRIES_HISTORY=$(/home/user/git/maxos/scripts/ff-export.sh | grep -Ev "file://|^,|Image," | sort | uniq | sed 's/ http/xdg-open http/g' | tail -n +2)

ENTRIES="${ENTRIES_HISTORY}"
echo "$ENTRIES"

# Use $ROFI_CMD to display the entries and select one
SELECTED_ENTRY=$(echo "$ENTRIES" | cut -d '|' -f 1 | $ROFI_CMD -i -dmenu -p "maxos >")

# Find the corresponding command for the selected entry
SELECTED_COMMAND=$(echo "$ENTRIES" | grep "^$SELECTED_ENTRY|" | cut -d '|' -f 2 | tail -1)

perform_search() {
    local url="$1"
    shift  # Remove the URL from arguments, leaving only the search query
    local search_query="$@"

    # Construct the search URL
    search_url="${url}${search_query// /+}"

    if [[ $search_query != "" ]]; then
        # Open the search URL in the default web browser
        xdg-open "$search_url"
        sleep 1
        i3-msg "[title=\"$search_query.*Firefox\"] focus"
    fi
}

case "$SELECTED_COMMAND" in
    *)
        eval "$SELECTED_COMMAND"

        # Focus Firefox if xdg-open command
        if [[ $SELECTED_COMMAND =~ .*xdg-open.* ]]; then
            i3-msg "[title=\".*Firefox\"] focus"
        fi
    ;;
esac

#!/usr/bin/env bash

ROFI_CMD="rofi"

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

SEARCH_QUERY=$($ROFI_CMD -dmenu -p "Google search query")
perform_search "https://www.google.co.uk/search?q=" "$SEARCH_QUERY"

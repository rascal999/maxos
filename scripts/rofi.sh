#!/usr/bin/env bash

ROFI_CMD="rofi -theme /home/user/git/maxos/resources/rofi/theme"

# Path to your SQLite database file
DB_FILE="/home/user/Data/resources/rofi.db"

# SQLite query to select entries and commands from your database
QUERY="SELECT entry_name, command FROM rofi;"

# Execute the SQLite query and store the results in a variable
ENTRIES=$(sqlite3 "$DB_FILE" "$QUERY")

# Use $ROFI_CMD to display the entries and select one
SELECTED_ENTRY=$(echo "$ENTRIES" | sort | cut -d '|' -f 1 | $ROFI_CMD -i -dmenu -p "maxos >")

# Find the corresponding command for the selected entry
SELECTED_COMMAND=$(echo "$ENTRIES" | grep "^$SELECTED_ENTRY|" | cut -d '|' -f 2)

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
        i3-msg "[title=\"$search_query\"] focus"
    fi
}

case "$SELECTED_COMMAND" in
    amazon)
        SEARCH_QUERY=$($ROFI_CMD -dmenu -p "Amazon search")
        perform_search "https://www.amazon.co.uk/s?k=" "$SEARCH_QUERY"
    ;;
    github-topic)
        SEARCH_QUERY=$($ROFI_CMD -dmenu -p "GitHub topic")
        perform_search "https://github.com/topics/" "$SEARCH_QUERY"
    ;;
    google)
        SEARCH_QUERY=$($ROFI_CMD -dmenu -p "Google search query")
        perform_search "https://www.google.com/search?q=" "$SEARCH_QUERY"
    ;;
    gdrive)
        SEARCH_QUERY=$($ROFI_CMD -dmenu -p "Drive search")
        perform_search "https://drive.google.com/drive/u/0/search?q=" "$SEARCH_QUERY"
    ;;
    jql)
        SEARCH_QUERY=$($ROFI_CMD -dmenu -p "JQL")
        perform_search "https://mangopay.atlassian.net/issues/?jql=" "$SEARCH_QUERY"
    ;;
    jira-ticket)
        SEARCH_QUERY=$($ROFI_CMD -dmenu -p "Ticket ID")
        perform_search "https://mangopay.atlassian.net/browse/" "$SEARCH_QUERY"
    ;;
    nix-pkg)
        SEARCH_QUERY=$($ROFI_CMD -dmenu -p "NixOS pkg")
        perform_search "https://search.nixos.org/packages?channel=23.11&from=0&size=50&sort=relevance&type=packages&query=" "$SEARCH_QUERY"
    ;;
    youtube)
        SEARCH_QUERY=$($ROFI_CMD -dmenu -p "YouTube search")
        perform_search "https://www.youtube.com/results?search_query=" "$SEARCH_QUERY"
    ;;
    wikipedia)
        SEARCH_QUERY=$($ROFI_CMD -dmenu -p "Wiki search")
        perform_search "https://en.wikipedia.org/w/index.php?search=" "$SEARCH_QUERY"
    ;;
    notion)
        xdg-open "https://notion.so/"
    ;;
    *)
        eval "$SELECTED_COMMAND"
    ;;
esac

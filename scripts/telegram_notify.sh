#!/usr/bin/env bash

source /etc/api-telegram

if [[ "$#" -lt "1" ]]; then
  echo "$0 <message>"
  echo
  echo "Example: $0 \"Test message\""
  echo
fi

MESSAGE=$1
DISABLE_NOTIFACITON="false"

curl -X POST \
     -H 'Content-Type: application/json' \
     -d "{\"chat_id\": \"$CHAT_ID\", \"parse_mode\":\"MarkdownV2\", \"text\": \"\`\`\`$MESSAGE\`\`\`\", \"disable_notification\": $DISABLE_NOTIFICATION}'" \
     https://api.telegram.org/bot${BOT_API_KEY}/sendMessage

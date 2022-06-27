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
JSON='{"chat_id": "'$CHAT_ID'", "parse_mode":"MarkdownV2", "text": "```text
'$HOSTNAME' | '$MESSAGE'```", "disable_notification": '$DISABLE_NOTIFICATION'}'

curl -s -X POST \
     -H 'Content-Type: application/json' \
     -d "$JSON" \
     https://api.telegram.org/bot${BOT_API_KEY}/sendMessage > /dev/null

if [[ "$?" == "0" ]]; then
  echo "Notified via Telegram."
else
  echo "ERROR: Telegram notify issue."
fi

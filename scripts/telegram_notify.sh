#!/usr/bin/env bash

usage() {
  echo "Telegram notify script"
  echo "Usage: $0 -m <message> [-a] [-e] [-g] [-o] [-p] [-t] [-v] [-w]" 1>&2;
  echo
  echo "-a (Alert)            Notification alert"
  echo "-m (Message)          Message to send"
  echo
  echo "Examples:"
  echo "# Non-urgent message"
  echo "$0 -m \"Not urgent\""
  echo
  echo "# Urgent message"
  echo "$0 -a -m \"Urgent\""
  exit 1;
}

arg_alert="true"
arg_message="empty"

while getopts am: flag
do
    case "${flag}" in
        a) arg_alert="false";;
        m) arg_message=${OPTARG};;
    esac
done

# No options specified?
if [ "${arg_message}" == "empty" ]; then
    usage
fi

source /etc/api-telegram

if [[ "$#" == "2" ]]; then
  DISABLE_NOTIFICATION="@"
fi

DISABLE_NOTIFACITON="false"
JSON='{"chat_id": "'$CHAT_ID'", "parse_mode":"MarkdownV2", "text": "```text
'$HOSTNAME' | '$arg_message'```", "disable_notification": '$arg_alert'}'

curl -s -X POST \
     -H 'Content-Type: application/json' \
     -d "$JSON" \
     https://api.telegram.org/bot${BOT_API_KEY}/sendMessage > /dev/null

if [[ "$?" == "0" ]]; then
  echo "Notified via Telegram."
else
  echo "ERROR: Telegram notify issue."
fi

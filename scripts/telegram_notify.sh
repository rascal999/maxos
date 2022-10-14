#!/usr/bin/env bash

usage() {
  echo "Telegram notify script"
  echo "Usage: $0 -m <message> [-a] [-m] [-q]" 1>&2;
  echo
  echo "-a (Alert)            Notification alert"
  echo "-m (Message)          Message to send"
  echo "-q (Quiet)            Don't output to stdout"
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
arg_quiet="false"

while getopts am:q flag
do
    case "${flag}" in
        a) arg_alert="false";;
        m) arg_message=${OPTARG};;
        q) arg_quiet="true";;
    esac
done

# No options specified?
if [ "${arg_message}" == "empty" ]; then
    usage
fi

if [[ ! -f /etc/api-telegram ]]; then
  echo "ERROR: Cannot notify via Telegram, no API key"
  exit 0
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

if [[ "$arg_quiet" == "false" ]]; then
  if [[ "$?" == "0" ]]; then
    echo "Notified via Telegram."
    exit 0
  else
    echo "ERROR: Telegram notify issue."
    exit 1
  fi
fi

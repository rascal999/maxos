#!/usr/bin/env bash

TEXT=`flameshot gui --raw | tesseract -l eng stdin stdout`
PROMPT="1. Summarise this chat thread in one or two sentences.
2. Create a table with two columns, 'Reply Type', and 'Reply'.
3. Populate table with 3-8 rows of different potential replies.
4. Don't include chat thread in response.
5. Don't use exclamation marks in replies."

QUERY=`echo "$PROMPT

$TEXT" | jq -s -R -r @uri`

firefox http://localhost:3000/?q=$QUERY

#!/usr/bin/env bash
set -e

URL="https://www.inberlinwohnen.de/wohnungsfinder"

# Fetch the page and extract listing IDs
curl -s "$URL" | grep -o 'data-id="[0-9]\+"' | sort > current.txt

# If previous.txt exists, compare
if [ -f previous.txt ]; then
  diff previous.txt current.txt > diff.txt || true
  if [ -s diff.txt ]; then
    # Send Telegram alert
    curl -s -X POST "https://api.telegram.org/bot$TG_TOKEN/sendMessage" \
      -d chat_id="$TG_CHAT_ID" \
      -d text="🚨 New listing https://www.inberlinwohnen.de/mein-bereich/wohnungsfinder"
  fi
fi

# Save current snapshot for next run
mv current.txt previous.txt

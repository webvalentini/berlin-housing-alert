#!/usr/bin/env bash
set -e

URL="https://www.inberlinwohnen.de/wohnungen/"

# Fetch the listings and extract listing IDs
curl -s "$URL" | grep -o 'data-id="[0-9]\+"' | sort > current.txt

# Compare with previous run
if [ -f previous.txt ]; then
  diff previous.txt current.txt > diff.txt || true
  if [ -s diff.txt ]; then
    curl -s -X POST "https://api.telegram.org/bot$TG_TOKEN/sendMessage" \
      -d chat_id="$TG_CHAT_ID" \
      -d text="🚨 New listing: https://www.inberlinwohnen.de/mein-bereich/wohnungsfinder"
  fi
fi

# Save current snapshot
mv current.txt previous.txt

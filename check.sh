#!/usr/bin/env bash
set -e

echo "Debug: sending test message"

curl -s -X POST "https://api.telegram.org/bot$TG_TOKEN/sendMessage" \
  -d chat_id="$TG_CHAT_ID" \
  -d text="🚨 TEST ALERT from GitHub Actions"

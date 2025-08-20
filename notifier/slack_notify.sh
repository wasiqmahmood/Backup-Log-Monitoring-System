#!/usr/bin/env bash
set -euo pipefail

# Load webhook
if [[ -f /etc/mern-alert/config ]]; then
  # shellcheck disable=SC1091
  source /etc/mern-alert/config
fi
if [[ -z "${SLACK_WEBHOOK_URL:-}" ]]; then
  echo "SLACK_WEBHOOK_URL not set" >&2
  exit 1
fi

# Read whole stdin as message
msg="$(cat)"
hostname_str="$(hostname)"
ts="$(date -Is)"

# Build JSON payload safely
payload="$(jq -n --arg text "[$hostname_str] [$ts]
$msg" '{text: $text}')"

# Send
http_code="$(curl -sS -o /tmp/slack_out.$$ -w '%{http_code}' \
  -X POST -H 'Content-type: application/json' \
  --data "$payload" "$SLACK_WEBHOOK_URL" || true)"

if [[ "$http_code" != "200" ]]; then
  echo "Slack post failed (HTTP $http_code). Body:" >&2
  cat /tmp/slack_out.$$ >&2
  exit 2
fi
rm -f /tmp/slack_out.$$



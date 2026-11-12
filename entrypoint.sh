#!/bin/sh
# Render sets $PORT; UUID comes from a Render environment variable (never baked into files).
set -e
PORT="${PORT:-10000}"
if [ -z "$UUID" ]; then
  echo "UUID environment variable is required" >&2
  exit 1
fi
sed -e "s/__PORT__/$PORT/" -e "s/__UUID__/$UUID/" /etc/xray/config.template.json > /etc/xray/config.json
exec /usr/local/bin/xray run -c /etc/xray/config.json

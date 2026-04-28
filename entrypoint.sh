#!/bin/bash

set -e

echo "[+] Starting lightweight Hysteria server..."

CERT="/app/cert.pem"
KEY="/app/key.pem"
CONFIG="/app/config.yaml"

PASSWORD="${PASSWORD:-123456}"
PORT="${PORT:-443}"

# منع تكرار إنشاء الشهادة
if [ ! -f "$CERT" ] || [ ! -f "$KEY" ]; then
  echo "[+] Generating self-signed TLS cert..."

  openssl req -x509 -newkey rsa:2048 \
    -keyout "$KEY" \
    -out "$CERT" \
    -days 365 \
    -nodes \
    -subj "/CN=localhost"
fi

echo "[+] Building config..."

cat > "$CONFIG" <<EOF
listen: :$PORT

tls:
  cert: $CERT
  key: $KEY

auth:
  type: password
  password: "$PASSWORD"

bandwidth:
  up: 50 mbps
  down: 50 mbps
EOF

echo "[+] Launching Hysteria..."
exec /app/hysteria server -c "$CONFIG"

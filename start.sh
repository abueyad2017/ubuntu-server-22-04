#!/bin/bash

set -e

echo "[+] Starting lightweight Hysteria server..."

# تقليل الضغط على RAM
ulimit -n 1024

CERT_DIR="/app/certs"
mkdir -p $CERT_DIR

echo "[+] Generating TLS cert (self-signed)..."

openssl req -x509 -newkey rsa:2048 -nodes \
-keyout $CERT_DIR/key.pem \
-out $CERT_DIR/cert.pem \
-days 3650 \
-subj "/CN=railway.local" \
>/dev/null 2>&1

echo "[+] Building config..."

cat config.template.yaml | \
sed "s|CERT_PATH|$CERT_DIR/cert.pem|g" | \
sed "s|KEY_PATH|$CERT_DIR/key.pem|g" > /app/config.yaml

echo "[+] Launching Hysteria..."

# تشغيل مع حماية من crash restart loop
while true; do
  hysteria server -c /app/config.yaml
  echo "[!] Server crashed, restarting in 2s..."
  sleep 2
done

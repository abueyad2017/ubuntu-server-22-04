#!/bin/bash

echo "Starting Hysteria VPN Server..."

# تحميل Hysteria
curl -Lo hysteria https://github.com/apernet/hysteria/releases/latest/download/hysteria-linux-amd64
chmod +x hysteria
mv hysteria /usr/local/bin/

# إنشاء إعدادات بسيطة
mkdir -p /etc/hysteria

cat > /etc/hysteria/config.yaml <<EOF
listen: :443

auth:
  type: password
  password: "change_me_123"

tls:
  cert: ""
  key: ""

masquerade:
  type: proxy
  proxy:
    url: https://www.google.com
EOF

echo "Hysteria installed. Waiting..."

hysteria server -c /etc/hysteria/config.yaml

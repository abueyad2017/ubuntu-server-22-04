FROM teddysun/xray:latest

ENV PORT=443
ENV UUID=12345678-1234-1234-1234-1234567890ab

RUN printf '{\n\
    "inbounds": [{\n\
        "port": %s,\n\
        "protocol": "vless",\n\
        "settings": {\n\
            "clients": [{"id": "%s"}],\n\
            "decryption": "none"\n\
        },\n\
        "streamSettings": {\n\
            "network": "tcp"\n\
        }\n\
    }],\n\
    "outbounds": [{\n\
        "protocol": "freedom"\n\
    }]\n\
}' "$PORT" "$UUID" > /etc/xray/config.json

CMD ["xray", "-config", "/etc/xray/config.json"]

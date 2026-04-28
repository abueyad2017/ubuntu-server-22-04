FROM alpine:3.20

RUN apk add --no-cache \
    curl \
    bash \
    openssl

WORKDIR /app

# تحميل Hysteria مباشرة
RUN curl -L -o hysteria https://github.com/apernet/hysteria/releases/latest/download/hysteria-linux-amd64 && \
    chmod +x hysteria

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

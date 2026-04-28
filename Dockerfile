FROM alpine:3.19

# أدوات خفيفة فقط
RUN apk add --no-cache \
    bash \
    curl \
    openssl

WORKDIR /app

# تحميل Hysteria (خفيف)
RUN curl -L -o hysteria https://github.com/apernet/hysteria/releases/latest/download/hysteria-linux-amd64 \
    && chmod +x hysteria \
    && mv hysteria /usr/local/bin/

COPY start.sh /start.sh
COPY config.template.yaml /config.template.yaml

RUN chmod +x /start.sh

# تقليل استهلاك الموارد
ENV MALLOC_ARENA_MAX=2

CMD ["/start.sh"]

FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    curl wget bash iproute2 iptables ca-certificates unzip \
    && apt clean

WORKDIR /app

COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]

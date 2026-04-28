FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    curl wget nano sudo openssh-server iproute2 iputils-ping \
    wireguard-tools ca-certificates && \
    apt clean

RUN mkdir /var/run/sshd

RUN echo 'root:ChangeMe123!' | chpasswd

EXPOSE 22

COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]

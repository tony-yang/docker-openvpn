FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
    easy-rsa \
    iptables \
    openvpn \
 && rm -rf /var/lib/apt/lists/*

ENV HOME /root

WORKDIR /root

RUN make-cadir openvpn-ca \
 && mkdir -p client-configs/files && chmod 700 client-configs/files

COPY config/vars openvpn-ca/vars
COPY config/client_base.conf client-configs/base.conf
COPY config/make_client_config.sh client-configs/make_client_config.sh
COPY config/server.conf server.conf
COPY openvpn-starter.sh openvpn-starter.sh

RUN chmod 700 client-configs/make_client_config.sh \
 && chmod 700 openvpn-starter.sh

CMD ["/root/openvpn-starter.sh"]

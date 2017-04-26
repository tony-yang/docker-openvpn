#!/bin/bash

sleep 10s

IP=$(hostname -I)

cd /root/openvpn-ca
source /root/openvpn-ca/vars
/root/openvpn-ca/clean-all
export EASY_RSA="${EASY_RSA:-.}"
/root/openvpn-ca/pkitool --initca
/root/openvpn-ca/pkitool --server server
/root/openvpn-ca/build-dh
openvpn --genkey --secret /root/openvpn-ca/keys/ta.key
/root/openvpn-ca/pkitool client

cd /root/openvpn-ca/keys
cp ca.crt ca.key server.crt server.key ta.key dh2048.pem /etc/openvpn

cd /root
cp server.conf /etc/openvpn

iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j SNAT --to-source $IP

mkdir -p /dev/net
if [ ! -f /dev/net/tun ]; then
  mknod /dev/net/tun c 10 200
fi

cd /root/client-configs
/root/client-configs/make_client_config.sh client

while :
do
  sleep 10m
done

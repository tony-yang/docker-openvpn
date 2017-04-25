#!/bin/bash

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

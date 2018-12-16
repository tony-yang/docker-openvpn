#!/bin/bash

SERVER_IP=$(curl https://ipecho.net/plain)

sudo bash -c "export SERVER_NAME='$SERVER_IP' && export CLIENT_NAME='clientkey' && export CLIENT_EMAIL='client@email.com' && docker-compose build openvpn && docker-compose up -d"

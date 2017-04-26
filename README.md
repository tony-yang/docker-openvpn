# docker-openvpn
A minimalistic docker image for running the OpenVPN server.

The server configuration is set to follow convention and defaults as much as possible. Configurable options are not provided through external input such as environment variables. Users can always change the server configuration under the `config/server.conf`.

The client profile will be available in the mounted volume under the `~/vpn` directory once the docker container finishes initialization.


## User Guide
To start the OpenVPN Server
```
sudo bash -c "export SERVER_NAME='my_server_name' && \
  export CLIENT_NAME='client' && \
  export CLIENT_EMAIL='client@email.com' && \
  docker-compose build openvpn && \
  docker-compose up -d"
```


## Environment Variables
Required Variables:
- `SERVER_NAME` - Sets the domain name or IP address of the OpenVPN server. If this environment variable is not set, the client config will be populated with `my_server_name`, which needs to be manually populated later, or the connection request will fail.

Optional Variables:
- `CLIENT_NAME` - Sets the client profile name. Defaults to `client`
- `CLIENT_EMAIL` - Sets the user email. Defaults to `client@email.com`


## Security Discussion
- The NET_ADMIN capability is added to the Docker container.
- The client profile is not passphrase protected

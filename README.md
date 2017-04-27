# docker-openvpn
A minimalistic docker image for running the OpenVPN server on Ubuntu 16.04 Server.

The server configuration is set to follow convention and defaults as much as possible. Configurable options are not provided through external input such as environment variables. Users can always change the server configuration under the `config/server.conf`.

The client profile will be available in the mounted volume under the `~/vpn` directory once the docker container finishes initialization.


## Prerequisite
Before using this Docker image, please configure the host network and firewall rules.

Allow IP Forwarding
```
sudo vim /etc/sysctl.conf

# Uncomment the net.ipv4.ip_forward line
net.ipv4.ip_forward=1

# Exit and apply the new rule
sudo sysctl -p
```

Allow UFW forward policy
```
sudo vim /etc/default/ufw

# Change the forward policy value from DROP to ACCEPT
DEFAULT_FORWARD_POLICY="ACCEPT"
```

Open the port 1194 and 22
```
sudo ufw allow 1194/tcp
sudo ufw allow OpenSSH
sudo ufw reload
```


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


## Additional Notes
- Any contributions are welcome. If you decide to send a pull request, please justify why the change will benefit others in the pull request.
- The use of the Ubuntu 16.04 base image in the Dockerfile was intentional. There are other smaller linux images such as the Alpine image that can probably achieve the same goal. However, since I'm using a LTS Ubuntu server and all my projects will be running on a LTS Ubuntu server, I decided to make everything consistent so that it will be easier for me to maintain. If you like to use this image but want to have a smaller footprint, feel free to fork the project. Alternatively, there is another OpenVPN docker image by `kylemanna` that you can take a look at.
- The NET_ADMIN capability is added to this Docker image.
- The client profile is not passphrase protected.


## References
These references provided inspirations and insights into some of the problems I have encountered along the way. Thanks to those authors for sharing them.

- https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-ubuntu-16-04 (The project's workflow and configuration was mostly based on this tutorial)
- https://github.com/kylemanna/docker-openvpn (It was a bit overkill for my purpose but highly recommend to take a look)
- https://www.karlrupp.net/en/computer/nat_tutorial (A super useful tutorial on NAT and iptables)

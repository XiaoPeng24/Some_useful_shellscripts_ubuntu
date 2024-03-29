#!/bin/bash
# This script is to build the shadowsocks server in the VPS,
# in order to visit some foreign sites

# dependencies
apt-get update
apt-get install python-pip
pip install --upgrade pip
apt-get install git
pip install git+https://github.com/shadowsocks/shadowsocks.git@master

# install chacha20
apt-get install build-essential
wget https://github.com/jedisct1/libsodium/releases/download/1.0.8/libsodium-1.0.8.tar.gz
tar xf libsodium-1.0.8.tar.gz && cd libsodium-1.0.8
./configure && make -j2
make install
ldconfig

# config the Shadowsocks server
touch /etc/shadowsocks.json
echo '{"server":"::", "server_port":8388, "local_address": "127.0.0.1", "local_port":1080, "password":"xpxpxp", "timeout":300, "method":"chacha20", "fast_open": false }' > /etc/shadowsocks.json

# start the server
ssserver -c /etc/shadowsocks.json -d start
#!/bin/bash

sudo apt update
sudo apt install -y docker.io

sudo ip link add name docker0 type bridge
sudo ip addr add dev docker0 172.17.0.1/16
sudo usermod -aG docker $USER
newgrp docker
sudo systemctl restart docker
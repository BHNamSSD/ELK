#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
	echo "please run this file with root!"
	exit 1
fi
sudo apt update

sudo apt install traceroute

sudo apt-get install apt-transport-https

wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-8.x.list

sudo apt-get update

sudo apt-get install kibana





#!/bin/bash

sudo apt-get update -y
sudo apt-get install net-tools -y
sudo apt-get install nodejs -y
sudo apt-get install npm -y

git clone https://github.com/omondragon/consulService
cd consulService/app
npm install consul
npm install express
cd ..
cd ..

sudo consul join 192.168.100.4

wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update && sudo apt install consul -y
consul -v

consul agent -ui -server -bootstrap-expect=1 -client=0.0.0.0 -data-dir=\tmp\consul -node=agent-one -bind=192.168.100.3 -enable-script-checks=true -config-dir=/etc/consul.d

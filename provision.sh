#!/bin/bash

# general stuff
sudo apt-get update && apt-get install -y curl build-essential

# Install go
echo "Downloading Go"
curl --silent https://storage.googleapis.com/golang/go$GO_VERSION.linux-amd64.tar.gz > /tmp/go.tar.gz
echo "Extracting Go"
tar -xvzf /tmp/go.tar.gz --directory /home/vagrant >/dev/null 2>&1
echo "Setting Go environment variables"
mkdir /home/vagrant/gopath
chmod -R 777 /home/vagrant/gopath
echo 'export GOROOT="/home/vagrant/go"' >> /home/vagrant/.bashrc
echo 'export GOPATH="/home/vagrant/gopath"' >> /home/vagrant/.bashrc
echo 'export PATH="$PATH:$GOROOT/bin:$GOPATH/bin"' >> /home/vagrant/.bashrc

# Install nodejs
echo "Download and install NodeJS $SETUP_NODE_VERSION"
curl -sL https://deb.nodesource.com/setup_$SETUP_NODE_VERSION | bash -
apt-get install -y nodejs
echo "Install npm $NPM_VERSION"
npm install npm@$NPM_VERSION -g

# Install docker
echo "Install Docker"
sudo apt-get update && apt-get -y install \
	apt-transport-https ca-certificates curl gnupg2 software-properties-common

curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
sudo apt-get update && apt-get -y install docker-ce

# Install docker-compose
echo "Install Docker-Compose"
curl -L https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Add user vagrant to group docker
echo "Add user vagrant to group docker"
sudo gpasswd -a vagrant docker
newgrp docker

# Add hyperledger fabrice platform specific binaries
echo "Add hyperledger fabrice platform specific binaries"
cd /home/vagrant/gopath
curl -sSL https://goo.gl/eYdRbX | bash

# Provision completed!
echo "Provision completed!"
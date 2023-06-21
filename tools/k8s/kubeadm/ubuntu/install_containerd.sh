#!/bin/bash

sudo apt-get update
sudo apt-get install ca-certificates curl gnupg

#Make the directory if not present
dir="/etc/apt/keyrings"
if [ -d "$dir" ];
then
echo "dir exists"
else
mkdir $dir
fi

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

#Use the following command to set up the repository
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

#Update the apt package index:
sudo apt-get update

#Only install containerd
sudo apt-get install containerd.io
#!/bin/bash
# Created by Willena on 04/05/2015
#
#This script is made to simplfy installation of owncloud, for debian 7,6,8

echo "___________ Debian Version  ___________"
VERSION=$(cat /etc/debian_version)
echo "You are using debian v$VERSION"
IFS='.' read -a array <<< "$VERSION"
echo "Major version  is ${array[0]}"

echo "____________ Source update ____________"
echo "deb http://download.opensuse.org/repositories/isv:/ownCloud:/community/Debian_${array[0]}.0/ /" >> /etc/apt/sources.list.d/owncloud.list 
wget "http://download.opensuse.org/repositories/isv:ownCloud:community/Debian_${array[0]}.0/Release.key"
apt-key add - < Release.key
apt-get update
echo "_________ Installing owncloud _________"
apt-get install owncloud -y --force-yes
echo "_________ Finished ! _________"
echo "You can access owncloud with http://$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/')/owncloud/ and continue configuration"

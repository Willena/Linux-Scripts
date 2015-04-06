#!/bin/bash
echo "starting to create swapFile"
fallocate -l 4G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "Swap File Created"

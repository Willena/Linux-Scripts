#!/bin/bash
echo "Removing swap file"
swapoff /swapfile
swapon -s
rm /swapfile
echo "swap File removed"

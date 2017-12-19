#!/bin/bash
sudo mkfs -t ext4 /dev/xvdf
mkdir /mnt/data1
mount /dev/xvdf /mnt/data1

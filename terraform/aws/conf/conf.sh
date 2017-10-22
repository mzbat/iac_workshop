#!/bin/bash
sudo mkfs.ext4 /dev/xvdf
mkdir /mnt/data1
mount /dev/xvdf /mnt/data1

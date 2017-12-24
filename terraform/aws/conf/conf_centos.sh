#!/bin/bash
#
# Author: @theDevilsVoice
# Date: 09/08/2017
#
# Script Name: conf_centos.sh
#
# Description: Use this shell script to ensure your system
#
# Run Information:
#
# Error Log: Any output found in /path/to/logfile
#

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi
sudo mkfs -t ext4 /dev/xvdf
mkdir /mnt/data1
mount /dev/xvdf /mnt/data1
rpm -ivh https://yum.puppetlabs.com/el/7/products/x86_64/puppetlabs-release-22.0-2.noarch.rpm
yum install -y puppet
echo "188.166.26.120 puppet.bitsmasher.net puppet" >> /etc/hosts
sed -i '/main/a      server=puppet.bitsmasher.net' /etc/puppet/puppet.conf 
systemctl restart puppet
puppet agent -t
